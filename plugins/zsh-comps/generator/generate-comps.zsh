#!/bin/zsh

# ============= // generate-comps.zsh //
#
# Parse getopt-style help texts for 
# options and generate zsh(1) completion function.
#
# Usage: 
#   gencomp program [--argument-for-help-text]
#
# ---------------------------------------------------

# Fetch $0 according to plugin standard proposed:
0="${${ZERO:-${0#$ZSH_ARGZERO}}:-${(%):-%N}}"
ZSH_COMPLETION_GENERATOR_SRCDIR=${0:A:h}

if [ -z $GENCOMPL_FPATH ]; then
    ZSH_COMPLETION_GENERATOR_DIR="$ZSH_COMPLETION_GENERATOR_SRCDIR/generated"
else
    ZSH_COMPLETION_GENERATOR_DIR="$GENCOMPL_FPATH"
fi

# Don't override existing functions - append
[[ -z "${fpath[(r)$ZSH_COMPLETION_GENERATOR_DIR]}" ]] && fpath=($fpath $ZSH_COMPLETION_GENERATOR_DIR)

# Which python to use?
python=$GENCOMPL_PY

[[ ! -d $ZSH_COMPLETION_GENERATOR_DIR ]] && command mkdir -p $ZSH_COMPLETION_GENERATOR_DIR

# a) Define default programs here (or provide the below zstyle in zshrc):
local -a programs
zstyle -a :plugin:zsh-completion-generator programs programs
(( ${#programs} )) || programs=(  )

# Anonymous function to have private variable scope
() {
    local prg name help code
    local -a i
    for prg in "${programs[@]}"; do
        name=$prg
        help=--help
        # Use "% *" trick to skip using regex
        if [[ ${prg% *} != $prg ]]; then
            i=( "${(@s/ /)prg}" )
            name=$i[1]
            if [[ -n "$i[2]" ]]; then
                help="$i[2]"
            fi
        fi
        test -f $ZSH_COMPLETION_GENERATOR_DIR/_$name || \
            $name $help 2>&1 | $python $ZSH_COMPLETION_GENERATOR_SRCDIR/generate-comps-help.py $name >! \
                $ZSH_COMPLETION_GENERATOR_DIR/_$name || {
                    code="${pipestatus[1]}"
                    command rm -f $ZSH_COMPLETION_GENERATOR_DIR/_$name
                    # Store error message into "err_$name", once
                    [[ ! -f $ZSH_COMPLETION_GENERATOR_DIR/err_$name ]] && \
                        echo "No options found for $name. Was fetching from following invocation:" \
                            "\`$name $help'.\nProgram reacted with exit code: $code." >! \
                                $ZSH_COMPLETION_GENERATOR_DIR/err_$name
                }
    done
}

# b) Or use function in shell:
gencomp() {
    if [[ -z "$1" || "$1" = "-h" || "$1" = "--help" ]]; then
        echo "Usage: gencomp program [--argument-for-help-text]"
        echo
        return 1
    fi

    local help=--help
    if [[ -n "$2" ]]; then
        help=$2
    fi

    "$1" $help 2>&1 | $python $ZSH_COMPLETION_GENERATOR_SRCDIR/generate-comps-help.py $1 >! \
    $ZSH_COMPLETION_GENERATOR_DIR/_$1 || ( local code="${pipestatus[1]}"
        command rm -f $ZSH_COMPLETION_GENERATOR_DIR/_$1 && \
        echo "No options found for '$1'. Was fetching from following invocation: \`$1 $help'." \
            "\nThe program reacted with exit code: $code."
    )
}
