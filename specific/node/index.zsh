# export FNM_DIR="${XDG_DATA_HOME}/fnm"

if [ -d "$FNM_DIR" ]; then
  PATH="${FNM_DIR}:${PATH}"
  eval "$(fnm env)"
fi

eval "$(fnm env --use-on-cd)"
