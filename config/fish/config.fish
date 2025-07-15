
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/stache/.config/miniconda3/bin/conda
    eval /Users/stache/.config/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/Users/stache/.config/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/stache/.config/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/stache/.config/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<


# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/stache/.lmstudio/bin
# End of LM Studio CLI section

