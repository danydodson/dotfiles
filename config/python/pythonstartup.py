# XDG compliant ~/.python_history

# export PYTHONSTARTUP="${XDG_CONFIG_HOME:-$HOME/.config}/python/pythonstartup.py"

import atexit
import os
import readline

histfile = os.path.join(os.getenv("XDG_CONFIG_HOME", os.path.expanduser("~/.config/python")), "python_history")
try:
    readline.read_history_file(histfile)
    readline.set_history_length(1000)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, histfile)
