function sash {
  source ./sash_bash
  sash_bash $@
}

# autocomplete

function _sash {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  echo $cur
  case "${COMP_CWORD}" in
    1)
      if [[ -z $_sash_instances ]]; then
        _sash_instances="$( aws ec2 $profile describe-instances --filters "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[].Tags[?Key==`Name`].Value[]' --output text )"
      fi

      COMPREPLY=($(compgen -W "${_sash_instances}" -- $cur))
      ;;
    2)
       COMPREPLY=($(compgen -W "set_user unset_user upload download list all" -- $cur))
       ;;
    3)
      if [[ "${COMP_WORDS[2]}" == "upload" ]]; then
        COMPREPLY=($(compgen -f "${cur}"))
      fi
      ;;
    4)
      if [[ "${COMP_WORDS[2]}" == "download" ]]; then
        COMPREPLY=($(compgen -d "${cur}"))
      fi
      ;;
  esac
}

source $(dirname $0)/bash_compatibility.sh
complete -F _sash sash
