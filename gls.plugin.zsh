# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  #alias ls="gls -F --color"
  alias l="gls -lAhX --color"
  alias ll="gls -lX --color"
  alias la='gls -lAX --color'
fi

# dealing with BSD od (different to GNU od)
\od -tx1z -Ax </dev/null >/dev/null 2>&1

if [ "$?" -eq "0" ]; then
  # found GNU od
  GNU_OD="od"
else
  \god -tx1z -Ax </dev/null >/dev/null 2>&1
  if [ "$?" -eq "0" ]; then
    # found GNU od
    GNU_OD="god"
  else
    GNU_OD=""
  fi
fi

if [ -n "$GNU_OD" ] ; then
  alias hd="$GNU_OD -tx1z -Ax"
else
  alias hd='od -tx1 -Ax'
fi

# dealing with BSD ls (different to GNU ls)
\ls --version >/dev/null 2>&1

if [ "$?" -eq "0" ]; then
    GNU_LS="ls"
    GNU_DIRCOLORS="dircolors"
else
    \gls --version >/dev/null 2>&1
    if [ "$?" -eq "0" ]; then
        GNU_LS="gls"
        GNU_DIRCOLORS="gdircolors"
    else
        GNU_LS=""
        GNU_DIRCOLORS=""
    fi
fi

echo pattern | \grep --color=auto pattern < /dev/null >/dev/null 2>&1
if [ "$?" -eq "0" ]; then
    # GNU grep
    GNU_GREP="grep"
else
    GNU_GREP=""
fi

case "$TERM" in
  dumb | emacs)
    alias ls="$GNU_LS -N"
    alias dir="$GNU_LS -laN"
    PROMPT="%m:%~> "
    unsetopt zle
    ;;
  cygwin)
    alias ls="$GNU_LS --show-control-chars --color=auto"
    alias dir="$GNU_LS -la --show-control-chars --color=auto"
    alias grep="$GNU_GREP --color=auto"
    ;;
  *)
    alias ls="$GNU_LS -N --color=auto"
    alias dir="$GNU_LS -laN --color=auto"
    alias grep="$GNU_GREP --color=auto"
    ;;
esac

if [ -z "$GNU_LS" ] ; then
    unalias ls
    alias dir='ls -la'
fi

if [ -n "$GNU_LS" -a -f $HOME/.dir_colors ] ; then
  eval `$GNU_DIRCOLORS -b $HOME/.dir_colors`
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

if [ -z "$GNU_GREP" ] ; then
    unalias grep
fi