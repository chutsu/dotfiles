#/bin/sh
# workout what OS shell is running on
case $( uname -s ) in
Linux)
    OS="LINUX"
    ;;
Darwin)
    OS="MAC"
    ;;
esac

echo "Removed old dotfiles"
rm -rf $HOME/.vim
rm -f $HOME/.vimrc
rm -f $HOME/.bash_profile
rm -f $HOME/.tmux.conf

echo "Created symlinks for the dotfiles"
ln -fs $PWD/vim $HOME/.vim
ln -fs $PWD/vimrc $HOME/.vimrc
ln -fs $PWD/bash_profile $HOME/.bash_profile
ln -fs $PWD/tmux.conf $HOME/.tmux.conf
ln -fs $PWD/inputrc $HOME/.inputrc
ln -fs $PWD/xmonad $HOME/.xmonad
ln -fs $PWD/xmobarrc $HOME/.xmobarrc

echo "Update Fonts cache!"
rm -rf $HOME/.fonts
rm -f $HOME/.fonts.conf
ln -fs $PWD/fonts   $HOME/.fonts
ln -fs $PWD/fonts.conf   $HOME/.fonts.conf
sudo fc-cache -fv



echo "Install vim plugins"
git submodule init
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
git submodule update

echo "Done! :)"
