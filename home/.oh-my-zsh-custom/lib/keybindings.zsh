export KEYTIMEOUT=1
set -s escape-time 0
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
