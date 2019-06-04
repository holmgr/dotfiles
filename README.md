# dotfiles
Personal dotfiles and vim configs. 

## Select configuration files to symlink
To install use GNU stow and run
  stow -t ~/. fish neovim tmux

## Neovim configuration
To configure, firstly [vim-plug][vim-plug] needs to be installed, and the the
listed packages.

    $ curl -L -o ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    $ nvim +PlugInstall +qa

[vim-plug]: https://github.com/junegunn/vim-plug
