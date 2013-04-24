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
rm $HOME/.vimrc
rm $HOME/.bash_profile
rm $HOME/.tmux.conf

echo "Install vim plugins"
git clone https://github.com/gmarik/vundle.git $PWD/vim/bundle/vundle

echo "Created symlinks for the dotfiles"
ln -s $PWD/vim $HOME/.vim
ln -s $PWD/vimrc $HOME/.vimrc
ln -s $PWD/bash_profile $HOME/.bash_profile
ln -s $PWD/tmux.conf $HOME/.tmux.conf

echo "Done! :)"
