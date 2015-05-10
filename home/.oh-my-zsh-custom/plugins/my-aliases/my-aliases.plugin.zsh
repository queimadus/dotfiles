alias sl=ls
alias lso="ls -alG | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"

alias afind='ack-grep -il'
alias hi='highlight'

alias -g C='| pbcopy'

alias gua='git checkout -- .'
alias gst='git status -s'

alias subl='sublime'
alias op='open .'
alias adbandroid='adb connect 192.168.154.186'

alias gloga='git log --oneline --decorate --color --graph --all'
alias gmerge='git mergetool --no-prompt --tool=sourcetree'
alias gunstage='git reset'
alias grmlocalbranches='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'

alias watch='watch -n 1'

alias dockerstopall='docker stop $(docker ps -q)'
alias dockerrmall='docker rm $(docker ps -a -q)'
alias dockerrminone='docker rmi -f $(docker images -f "dangling=true" -q)'

alias tac="awk '{ x = $0 "\n" x } END { printf "%s", x }'"
alias scala='scala -Dscala.color'

alias sbt='sbt -Dscala.color'

alias uttunnel='echo http://localhost:7889/gui; sshtunnel 7889 localhost 8080 home'
alias psg='ps aux | grep'
alias rvisualvm='jvisualvm --nosplash --openjmx service:jmx:rmi:///jndi/rmi://$1/jmxrmi'
alias sbtdebug='sbt "set Revolver.enableDebugging(port = 5005, suspend = true)"'
alias airdropdown='sudo ifconfig awdl0 down'
alias airdropup='sudo ifconfig awdl0 up'
alias vimw='vim $(which $1)'

alias vimaliases="vim $ZSH_CUSTOM/plugins/my-aliases/my-aliases.plugin.zsh"
alias vimfunctions="vim $ZSH_CUSTOM/lib/functions.zsh"
alias vimrc='vim $HOME/.vimrc.fork'
alias vimrcbefore='vim $HOME/.vimrc.before.fork'
