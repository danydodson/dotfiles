# ZSH Troubleshooting & Fixes

## Zsh Completions

Run the following command to verify where Zsh looks for completions:

```shell
echo $fpath
```

Ensure your custom directories are listed. If they are missing, add them to `.zshrc`:

```shell
fpath=("$HOME/.config/zsh/completions" "/usr/share/zsh/vendor-completions" $fpath)
```

Zsh caches autoloaded completions. If old or broken completions exist, remove them:

```shell
rm -f ~/.zcompdump*
```

Then **reload the completion system**:

```shell
autoload -U compinit && compinit
```

To check if a specific completion function is loaded:

```shell
whence -v _ffx
```

Expected output:

```
_ffx is a shell function
```

To list **all loaded completions**, use:

```shell
print -l ${(ok)functions}
```

To confirm that **all completion scripts in your directory are being loaded**:

```shell
for f in ~/.config/zsh/completions/*; do
  echo -n "$f -> "
  whence -v "${f##*/}"
done
```

If a completion is missing, explicitly register it:

```shell
autoload -Uz _ffx
compdef _ffx ffx
```

If this works, persist it in `.zshrc`:

```shell
fpath=("$HOME/.config/zsh/completions" "/usr/share/zsh/vendor-completions" $fpath)
autoload -Uz _ffx
compdef _ffx ffx
compinit
```

If completions are still missing, force-load and reload them:

```shell
autoload -U $fpath[1]/*(:t)
typeset -f _ffx
compinit
```

If completions **still** do not work, debug using:

```shell
compinit -D
zsh -xv -c "ffx " 2>&1 | tee debug.log
```

Check `debug.log` for any errors, such as missing functions or syntax issues.

To check if `_ffx` is being overridden:

```shell
which _ffx
whence _ffx
complete -p ffx
```

If another tool is overriding `_ffx`, it will appear in the output.
