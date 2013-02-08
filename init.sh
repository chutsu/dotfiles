#/bin/sh
echo "Removed old dotfiles"
rm -rf $HOME/.vim
rm $HOME/.vimrc
rm $HOME/.bash_profile
rm $HOME/.tmux.conf

echo "Created symlinks for the dotfiles"
ln -s $PWD/vim $HOME/.vim
ln -s $PWD/vimrc $HOME/.vimrc
ln -s $PWD/bash_profile $HOME/.bash_profile
ln -s $PWD/tmux.conf $HOME/.tmux.conf

echo "Initiate vim modules"
git submodule init
git submodule update

echo "Link gitignore files"
git config --global core.excludesfile $PWD/global_ignore

echo "Done! :)"
