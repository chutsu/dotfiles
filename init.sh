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

echo "Install vim plugins"
git submodule init
git submodule update
vim -c VundleInstall -c quitall
./vim/bundle/YouCompleteMe/install.sh --clang-completer

# FZF
exec ./vim/bundle/fzf/install


echo "Done! :)"
