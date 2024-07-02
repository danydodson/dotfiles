#!/bin/zsh

# changing dirs
setopt AUTO_PUSHD            # push the directory onto the directory stack after cd
setopt PUSHD_IGNORE_DUPS     # do not push multiple copies of the same directory onto the directory stack
setopt PUSHD_SILENT          # do not print the directory stack after pushd or popd
setopt PUSHD_TO_HOME         # push the home directory onto the directory stack when no argument is given to cd

# list comps
setopt AUTO_LIST             # automatically list choices on an ambiguous completion
setopt AUTO_MENU             # automatically use menu completion after the second consecutive request for completion
setopt NO_COMPLETE_ALIASES   # do not complete aliases
setopt LIST_PACKED           # do not expand the list of completions

# expand and glob
setopt EXTENDED_GLOB         # use extended globbing

# autocomp aliases
setopt ALIASES               # expand aliases
setopt AUTO_PARAM_SLASH      # automatically slash the last parameter on a command line
setopt CORRECT               # correct the spelling of commands

# job control
setopt CHECK_JOBS            # check for terminated background jobs immediately
setopt LONGLISTJOBS          # list jobs in long format
setopt NO_HUP                # do not kill jobs on shell exit

# allow in prompt
setopt PROMPT_SUBST          # allow command substitution in prompts
setopt INTERACTIVE_COMMENTS  # allow comments in interactive shell

# zsh options
unsetopt menu_complete       # do not autoselect the first completion entry
unsetopt flow_control        # disable start/stop characters in shell editor
unsetopt case_glob           # makes globbing (filename generation) case-sensitive 

setopt always_to_end         # move cursor to the end of a completed word
setopt auto_menu             # show completion menu on a successive tab press
setopt auto_list             # automatically list choices on ambiguous completion
setopt auto_param_slash      # if completed parameter is a directory, add a trailing slash
setopt complete_in_word      # complete from both ends of a word
setopt extended_glob         # needed for file modification glob modifiers with compinit
setopt path_dirs             # perform path search even on command names with slashes
setopt globdots              # files beginning with a . be matched without explicitly specifying the dot
