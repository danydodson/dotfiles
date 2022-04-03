export RBENV_ROOT="$HOME/.local/rbenv"

export PATH="$RBENV_ROOT/bin:$PATH"
export PATH="$RBENV_ROOT/shims:${PATH}"

# init according to man page
if (( $+commands[rbenv] ))
then
  eval "$(rbenv init -)"
fi

rbenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash | shell)
    eval "$(rbenv "sh-$command" "$@")"
    ;;
  *)
    command rbenv "$command" "$@"
    ;;
  esac
}
