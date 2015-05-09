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
         sash common-aliases my-aliases extract mosh)

source $ZSH/oh-my-zsh.sh

# User configuration
alias ls='ls --color=auto -ph'
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export LANG=en_US.UTF-8
export EDITOR='vim'
export VISUAL=/usr/local/bin/vim
