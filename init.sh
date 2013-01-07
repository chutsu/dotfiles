#/bin/sh
echo "Removed old dotfiles"
rm -rf $HOME/.vim
rm $HOME/.vimrc
rm $HOME/.bash_profile

echo "Created symlinks for the dotfiles"
ln -s $PWD/vim $HOME/.vim
ln -s $PWD/vimrc $HOME/.vimrc
ln -s $PWD/bash_profile $HOME/.bash_profile

echo "Download git projects from github"
mkdir -p ../proj/
cd ../proj
git clone https://github.com/chutsu/scripts.git
git clone https://github.com/chutsu/sim.git
git clone https://github.com/chutsu/nut.git
git clone https://github.com/chutsu/munit.git
git clone https://github.com/chutsu/liddell.git
git clone https://github.com/chutsu/dbench.git
git clone https://github.com/chutsu/dataviz.git
git clone https://github.com/chutsu/mineview.git
git clone https://github.com/chutsu/membank.git
cd ../dotfiles

echo "Initiate vim modules"
git submodule init
git submodule update

echo "Link gitignore files"
git config --global core.excludesfile $PWD/global_ignore

echo "Done! :)"
