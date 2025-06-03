#!/usr/bin/env zsh

# locally installed miniconda
__conda_setup="$('/Users/stache/.config/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/stache/.config/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/stache/.config/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/stache/.config/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
