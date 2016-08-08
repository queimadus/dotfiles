export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bruno"
DEFAULT_USER="bruno"

export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=1;40:bd=34;40:cd=34;40:su=0;40:sg=0;40:tw=0;40:ow=0;40:'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

DISABLE_AUTO_UPDATE="true"
DISABLE_LS_COLORS="true"
COMPLETION_WAITING_DOTS="true"

export ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

plugins=(git brew autojump colored-man sbt docker aws node npm zsh_reload fancy-ctrl-z 
         common-aliases my-aliases extract)

# Homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

source $ZSH/oh-my-zsh.sh

# User configuration
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty -ph' || alias ls='ls -phG'
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='vim'
export VISUAL=$(which vim)
export PYTHONPATH=/Library/Python/2.7/site-packages

# Misc
setjdk 1.8

ulimit -n 65536
ulimit -u 2048

