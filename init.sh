#/bin/sh
# DETERMINE OS
case $( uname -s ) in
Linux)
    OS="LINUX"
    ;;
Darwin)
    OS="MAC"
    ;;
esac

# REMOVE OLD DOTFILES
echo "Removed old dotfiles"
rm -rf $HOME/.vim
rm -f $HOME/.vimrc
rm -f $HOME/.bash_profile
rm -f $HOME/.tmux.conf
rm -rf $HOME/.i3
rm -f $HOME/.xinitrc
rm -f $HOME/.Xdefaults
rm -f $HOME/.muttrc
rm -rf $HOME/.mutt
rm -f $HOME/.xbindkeysrc

# SYMLINKS
echo "Created symlinks for the dotfiles"
ln -fs $PWD/vim $HOME/.vim
ln -fs $PWD/vimrc $HOME/.vimrc
ln -fs $PWD/bash_profile $HOME/.bash_profile
ln -fs $PWD/tmux.conf $HOME/.tmux.conf
ln -fs $PWD/inputrc $HOME/.inputrc
ln -fs $PWD/i3 $HOME/.i3
ln -fs $PWD/xinitrc $HOME/.xinitrc
ln -fs $PWD/Xdefaults $HOME/.Xdefaults
ln -fs $PWD/muttrc $HOME/.muttrc
ln -fs $PWD/mutt $HOME/.mutt
ln -fs $PWD/vimperatorrc $HOME/.vimperatorrc
ln -fs $PWD/xbindkeysrc $HOME/.xbindkeysrc

# FZF
exec ./vim/bundle/fzf/install


echo "Install vim plugins"
git submodule update
vim -c VundleInstall -c quitall
# git submodule add https://github.com/tpope/vim-fugitive.git vim/bundle/vim-fugitive
# git submodule add -f https://github.com/tomtom/tlib_vim.git vim/bundle/tlib_vim
# git submodule add https://github.com/MarcWeber/vim-addon-mw-utils.git vim/bundle/vim-addon-mw-utils
# git submodule add https://github.com/tpope/vim-surround.git vim/bundle/vim-surround
# git submodule add https://github.com/tpope/vim-markdown.git vim/bundle/vim-markdown
# git submodule add https://github.com/tomtom/tcomment_vim.git vim/bundle/tcomment_vim
# git submodule add https://github.com/scrooloose/nerdtree.git vim/bundle/nerdtree
# git submodule add https://github.com/derekwyatt/vim-fswitch.git vim/bundle/vim-fswitch
# git submodule add https://github.com/scrooloose/syntastic.git vim/bundle/syntastic
# git submodule add https://github.com/bronson/vim-trailing-whitespace.git vim/bundle/vim-trailing-whitespace
# git submodule add https://github.com/terryma/vim-multiple-cursors.git vim/bundle/vim-multiple-cursors
# git submodule add https://github.com/skammer/vim-css-color.git vim/bundle/vim-css-color
# git submodule add https://github.com/Lokaltog/vim-powerline.git vim/bundle/vim-powerline

echo "Done! :)"
