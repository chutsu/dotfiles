#/bin/bash
set -e  # exit on first error

install_desktop_pkgs() {
  sudo apt-get install -y \
    xterm \
    i3 \
    xinit \
    xbacklight \
    network-manager-gnome \
    pcmanfm \
    gnome-icon-theme-full \
    pavucontrol
}

install_dev_pkgs() {
  # General dev tools
  sudo apt-get install -y \
    xterm \
    git \
    vim-nox \
    tree \
    htop

  # C / C++
  sudo apt-get install -y \
    exuberant-ctags \
    automake \
    cmake \
    gcc \
    clang \
    clang-format \
    clang-tidy \

  # Python
  sudo apt-get install -y \
    libpython-dev \
    python-pip \
    libpython3-dev \
    python3-pip

  # Sh / Bash
  sudo apt-get install -y \
    shellcheck
}

install_user_pkgs() {
  sudo apt-get install -y \
    gtk-recordmydesktop \
    vlc

  sudo apt-get install -y \
    texlive-*
}

git_config() {
  git config --global user.name "Chris Choi"
  git config --global user.email "chutsu@gmail.com"
  git config --global push.default matching
}

setup_dotfiles() {
  # REMOVE OLD DOTFILES
  echo "remove old dotfiles"
  rm -rf "${HOME}/.vim"
  rm -f "${HOME}/.vimrc"
  rm -f "${HOME}/.bash_profile"
  rm -f "${HOME}/.tmux.conf"
  rm -rf "${HOME}/.i3"
  rm -f "${HOME}/.xinitrc"
  rm -f "${HOME}/.Xdefaults"
  rm -f "${HOME}/.muttrc"
  rm -rf "${HOME}/.mutt"
  rm -f "${HOME}/.xbindkeysrc"
  rm -f "${HOME}/.screenlayout"
  rm -rf "${HOME}/.gitconfig"

  # SYMLINKS
  echo "symlinks dotfiles"
  ln -fs "${PWD}/vim" "${HOME}/.vim"
  ln -fs "${PWD}/vim/vimrc" "${HOME}/.vimrc"
  ln -fs "${PWD}/tmux/tmux.conf" "${HOME}/.tmux.conf"
  ln -fs "${PWD}/i3" "${HOME}/.i3"
  ln -fs "${PWD}/configs/inputrc" "${HOME}/.inputrc"
  ln -fs "${PWD}/configs/xinitrc" "${HOME}/.xinitrc"
  ln -fs "${PWD}/configs/Xdefaults" "${HOME}/.Xdefaults"
  ln -fs "${PWD}/configs/xbindkeysrc" "${HOME}/.xbindkeysrc"
  ln -fs "${PWD}/configs/vimperatorrc" "${HOME}/.vimperatorrc"
  ln -fs "${PWD}/configs/bash_profile" "${HOME}/.bash_profile"
  echo "source ~/.bash_profile" >> "${HOME}/.bashrc"
  ln -fs "${PWD}/screenlayout" "${HOME}/.screenlayout"
  ln -fs "${PWD}/configs/gitconfig" "${HOME}/.gitconfig"

  return 0;
}

setup_vim() {
  echo "install vim plugins"
  git submodule init
  git submodule update
  vim -c VundleInstall -c quitall
  "./vim/bundle/fzf/install" --all

  # Build YouCompleteMe
  cd ./vim/bundle/YouCompleteMe
  ./install.py --clang-completer

  return 0;
}

setup() {
  git_config

  setup_dotfiles
  setup_vim
  echo "Done! :)"
}

# MAIN
setup