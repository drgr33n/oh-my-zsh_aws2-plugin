function agp2() {
  echo $AWS2_PROFILE
}

# AWS2 profile selection
function asp2() {
  if [[ -z "$1" ]]; then
    unset AWS_DEFAULT_PROFILE AWS_PROFILE AWS_EB_PROFILE
    echo AWS profile cleared.
    return
  fi

  local available_profiles=($(aws2_profiles))
  if [[ -z "${available_profiles[(r)$1]}" ]]; then
    echo "${fg[red]}Profile '$1' not found in '${AWS_CONFIG_FILE:-$HOME/.aws/config}'" >&2
    echo "Available profiles: ${(j:, :)available_profiles:-no profiles found}${reset_color}" >&2
    return 1
  fi

  export AWS_DEFAULT_PROFILE=$1
  export AWS_PROFILE=$1
  export AWS_EB_PROFILE=$1
}

function aws2_change_access_key() {
  if [[ -z "$1" ]]; then
    echo "usage: $0 <profile>"
    return 1
  fi

  echo Insert the credentials when asked.
  asp "$1" || return 1
  aws2 iam create-access-key
  aws2 configure --profile "$1"

  echo You can now safely delete the old access key running \`aws2 iam delete-access-key --access-key-id ID\`
  echo Your current keys are:
 
}

function aws2_profiles() {
  [[ -r "${AWS_CONFIG_FILE:-$HOME/.aws/config}" ]] || return 1
  grep '\[profile' "${AWS_CONFIG_FILE:-$HOME/.aws/config}"|sed -e 's/.*profile \([a-zA-Z0-9_\.-]*\).*/\1/'
}

function _aws2_profiles() {
  reply=($(aws2_profiles))
}
compctl -K _aws2_profiles asp aws2_change_access_key

# AWS prompt
function aws2_prompt_info() {
  [[ -z $AWS_PROFILE ]] && return
  echo "${ZSH_THEME_AWS2_PREFIX:=<aws2:}${AWS_PROFILE}${ZSH_THEME_AWS2_SUFFIX:=>}"
}

if [ "$SHOW_AWS2_PROMPT" != false ]; then
  RPROMPT='$(aws2_prompt_info)'"$RPROMPT"
fi


# Load aws2cli completions

# get aws2_zsh_completer.sh location from $PATH
_aws2_zsh_completer_path="$commands[aws2_zsh_completer.sh]"

[[ -r $_aws2_zsh_completer_path ]] && source $_aws2_zsh_completer_path
unset _aws2_zsh_completer_path