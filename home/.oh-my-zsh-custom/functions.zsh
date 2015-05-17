function setjdk() {
    if [ $# -ne 0 ]; then
        removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
        if [ -n "${JAVA_HOME+x}" ]; then
            removeFromPath $JAVA_HOME
        fi
        export JAVA_HOME=`/usr/libexec/java_home -v $@`
        export PATH=$JAVA_HOME/bin:$PATH
    fi
}

function removeFromPath() {
    export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

highlight() {
    egrep -i "$1|$"
}

bindports() {
    if [ -z "$1" ]
    then
        from=8080
    else
        from=$1
    fi

    if [ -z "$2" ]
    then
        to=80
    else
        to=$2
    fi

    sudo ipfw add 100 fwd 127.0.0.1,$from tcp from any to any $to in
}

unbindports() {
    sudo ipfw flush
}

rmqlisten() {
  unbuffer amqp-spy -H $1 -P $2 --format json $3 $4 | jq --unbuffered '.message' | sed -l 's/\\//g' | sed -l 's/^.\(.*\).$/\1/' | jq "."
}

sshtunnel() {
  ssh -L $1:$2:$3 $4 -N
}

ssht() {
  ssh $@ -t tmux -CC
}

function clear_sash {
  unset -v _sash_instances
}

function exportaws() {
  if [[ -n $1 ]]; then
    creds=$(grep -A 3 "\[profile $1\]" ~/.aws/config)
    access=$(echo $creds | sed -En 's/aws_access_key_id = (.*)$/\1/gp')
    secret=$(echo $creds | sed -En 's/aws_secret_access_key = (.*)$/\1/gp')
    export AWS_ACCESS_KEY_ID=$access
    export AWS_SECRET_ACCESS_KEY=$secret
    echo Set $1 aws vars
    echo $access
    echo $secret
  else
    echo Unset aws vars
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
  fi
}

function bk() {
  mv "$1" "$1".bk
}

function unbk() {
  newname=$(echo "$1" | sed -En 's/(.*)(\.bk$)/\1/p')
  mv "$1" "$newname"
}

function rvisualvm() {
  jvisualvm --nosplash --openjmx service:jmx:rmi:///jndi/rmi://$1/jmxrmi &
}

