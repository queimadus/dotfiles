# bruno theme

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

export LSCOLORS="exfxcxdxbxegedabagacad"
CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{black}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$1}" || fg="%f"
  if [[ $CURRENT_BG == 'NONE' || $4 == 1 ]]; then
    echo -n "%{$bg%}%{$fg%}"
  else
    echo -n " %{$bg%F{$CURRENT_BG}%}%{$fg%}" 
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

prompt_start() {
  #prompt_segment yellow black '['
  if [[ $VI_MODE == "[n]" ]]; then
    prompt_segment magenta black '['
  else
    prompt_segment yellow black '['
  fi
}

# End the prompt, closing any open segments
prompt_end() {

  local sts
  if [[ $RETVAL -ne 0 ]]; then 
    sts="]%{%F{red}%}$"
  else
    #sts="]$"
    sts="]%{%F{yellow}%}$"
  fi

  if [[ $VI_MODE == "[n]" ]]; then
    prompt_segment magenta black $sts
  else
    prompt_segment yellow black $sts
  fi

  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment magenta black "%(!.%{%F{magenta}%}.)$USER@%m"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  local ref dirty mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment yellow black "" 
    else
      prompt_segment green black "" 
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    if [ -e $(work_in_progress) ]; then
        wip_msg=""
    else
        wip_msg=" (wip)"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:git:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats '%u%c'
    vcs_info
    echo -n "${ref/refs\/heads\// }${vcs_info_msg_0_%% }$wip_msg${mode}"
  fi
}

# Dir: current working directory
prompt_dir() {
  #prompt_segment green black '%~'
  if [[ $VI_MODE == "[n]" ]]; then
    prompt_segment magenta black '%~'
  else
    prompt_segment green black '%~'
  fi
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment blue black "(`basename $virtualenv_path`)"
  fi
}

function zle-line-finish {
  prepare
  zle reset-prompt
  zle -R
}

prepare() {
  ## Main prompt
	build_prompt() {
		RETVAL=$?
		prompt_start
		prompt_virtualenv
		prompt_context
		prompt_dir
		prompt_git
		prompt_end
	}

	PROMPT='%{%f%b%k%}$(build_prompt) '
	RPROMPT=$(prompt_segment white black '[%*]')
}

prepare
