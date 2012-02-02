#/bin/sh

echo "Creating symlinks for the dotfiles"
ln -s $PWD/vim $HOME/.vim
ln -s $PWD/vimrc $HOME/.vimrc
ln -s $PWD/bash_profile $HOME/.bash_profile
echo "Done! :)"
