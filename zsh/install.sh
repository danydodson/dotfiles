echo "> Setting zsh as the default shell"

## create zsh directory
mkdir ~/.config/zsh 2>/dev/null

## add zsh to the list of accepted shells
sudo sh -c 'echo $(which zsh) >> /etc/shells'

## set zsh as the default shell
chsh -s $(which zsh)
