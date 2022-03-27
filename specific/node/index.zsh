export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"

export NPM_CONFIG_INIT_VERSION="0.0.1"
export NPM_CONFIG_INIT_LICENSE="MIT"
export NPM_CONFIG_STRICT_SSL="TRUE"
export NPM_CONFIG_MESSAGE="Cut %s (via npm version)"
export NPM_CONFIG_SIGN_GIT_TAG="TRUE"

export NPMRC_STORE="${HOME}/.local/npmrcs"

export FNM_DIR="${XDG_DATA_HOME}/fnm"

if [ -d "$FNM_DIR" ]; then
  PATH="${FNM_DIR}:${PATH}"
  eval "$(fnm env)"
fi

eval "$(fnm env --use-on-cd)"
