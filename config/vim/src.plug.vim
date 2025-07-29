"
" sets up all Vim / Neovim Plugins via Vim Plug
" for more info, see docs at: https://github.com/lissy93/dotfiles

" set paths for plug.vim and directory for plugins
  let vim_plug_location='$HOME/.config/vim/autoload/plug.vim'
  let vim_plug_plugins_dir='$HOME/.config/vim/plugins'
  
  " if vim-plug not present, install it now
  if !filereadable(expand(vim_plug_location))
    echom "Vim Plug not found, downloading to '" . vim_plug_location . "'"
    execute '!curl -o ' . vim_plug_location . ' --create-dirs' .
    \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echom "Next, run :PlugInstall to install all plugins"
  endif
  
  " if Plugins directory not yet exist, create it
  if empty(vim_plug_plugins_dir)
    call mkdir(vim_plug_plugins_dir, 'p')
  endif