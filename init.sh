#/bin/sh

# determine os
case $(uname -s) in
Linux)
    OS="LINUX"
    ;;
Darwin)
    OS="MAC"
    ;;
esac


init_dotfiles()
{
    # REMOVE OLD DOTFILES
    echo "remove old dotfiles"
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
    echo "creating symlinks for the dotfiles"
    ln -fs $PWD/vim $HOME/.vim
    ln -fs $PWD/vim/vimrc $HOME/.vimrc
    ln -fs $PWD/tmux/tmux.conf $HOME/.tmux.conf
    ln -fs $PWD/i3 $HOME/.i3
    ln -fs $PWD/configs/inputrc $HOME/.inputrc
    ln -fs $PWD/configs/xinitrc $HOME/.xinitrc
    ln -fs $PWD/configs/Xdefaults $HOME/.Xdefaults
    ln -fs $PWD/configs/xbindkeysrc $HOME/.xbindkeysrc
    ln -fs $PWD/configs/vimperatorrc $HOME/.vimperatorrc
    ln -fs $PWD/configs/bash_profile $HOME/.bash_profile

    return 0;
}

init_vim()
{
    echo "install vim plugins"
    git submodule init
    git submodule update
    vim -c VundleInstall -c quitall
    exec ./vim/bundle/fzf/install --all

    return 0;
}

init()
{
    init_dotfiles
    init_vim
    echo "Done! :)"
}

init
