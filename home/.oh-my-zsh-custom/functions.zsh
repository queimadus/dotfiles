function setjdk() {
  if [[ "$OSTYPE" = darwin* ]]; then
    if [ $# -ne 0 ]; then
        removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
        if [ -n "${JAVA_HOME+x}" ]; then
            removeFromPath $JAVA_HOME
        fi
        export JAVA_HOME=`/usr/libexec/java_home -v $@`
        export PATH=$JAVA_HOME/bin:$PATH
    fi
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
  unbuffer amqp-spy -H $1 -P $2 --format message $3 $4 ${@:5}
}

rmqlistenJ() {
  rmqlisten | jq "."
}

sshtunnel() {
  ssh -L $1:$2:$3 $4 -N
}

sshfwd() {
  ssh -L $1:"localhost":$2 $3 -N
}

ssht() {
  ssh $@ -t tmux -CC
}

function clear_sash {
  unset -v _sash_instances
}

function exportaws() {
  if [[ -n $1 ]]; then
    creds=$(grep -A 3 "\[$1\]" ~/.aws/credentials)
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
  url=$(echo "$1" | sed -E "s/(^http:\/\/)?(.*[^\/])(\/$)?/\2/")
  jvisualvm --nosplash --openjmx service:jmx:rmi:///jndi/rmi://"$url"/jmxrmi &
}

function aag() {
  ag --nogroup $@ $(pwd)
}

function cdf() {
  cd $(dirname "$1")
}

function vwhich() {
 vim "$(which $1)"
}

function retry {
  local retry_max=$1
  shift

  local count=$retry_max
  while [ $count -gt 0 ]; do
    "$@" && break
    count=$(($count - 1))
    sleep 1
  done

  [ $count -eq 0 ] && {
    echo "Retry failed [$retry_max]: $@" >&2
    return 1
  }
  return 0
}

function nvm () {
  if [[ -z $NVM_DIR ]]; then
    export NVM_DIR=~/.nvm
    source $(brew --prefix nvm)/nvm.sh
  fi
  nvm "$@"
}

