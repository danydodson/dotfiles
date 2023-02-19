grep export $HOME/.zshrc | while IFS=' =' read ignoreexport envvar ignorevalue; do
  launchctl setenv "${envvar}" "${!envvar}"
done