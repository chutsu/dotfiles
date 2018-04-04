#/bin/bash
set -e  # Exit on first error

install_dev_pkgs() {
  # General dev tools
  sudo apt-get install -y -qq \
    xterm \
    git \
    vim-nox \
    tree \
    htop \
    tmux

  # C / C++
  sudo apt-get install -y -qq \
    exuberant-ctags \
    automake \
    cmake \
    gcc \
    clang \
    clang-format \
    clang-tidy \

  # Python
  sudo apt-get install -y -qq \
    libpython-dev \
    python-pip \
    python-numpy \
    python-scipy \
    python-matplotlib \
    libpython3-dev \
    python3-pip \
    python3-numpy \
    python3-scipy \
    python3-matplotlib

  # Sh / Bash
  sudo apt-get install -y -qq \
    shellcheck
}

install_desktop_pkgs() {
  sudo apt-get install -y -qq \
    xterm \
    i3 \
    xinit \
    xbacklight \
    network-manager-gnome \
    pcmanfm \
    gnome-icon-theme-full \
    pavucontrol
}

install_user_pkgs() {
  sudo apt-get install -y -qq \
    gtk-recordmydesktop \
    vlc

  sudo apt-get install -y -qq \
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
  ln -fs "${PWD}/csgo/autoexec.cfg" "${HOME}/.steam/steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg/autoexec.cfg"
  ln -fs "${PWD}/csgo/practice.cfg" "${HOME}/.steam/steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg/practice.cfg"

  return 0;
}

install_vim() {
  # Remove existing vim installation
  sudo apt-get remove --purge \
    vim \
    vim-runtime \
    vim-gnome \
    vim-tiny \
    vim-gui-common
  sudo rm -rf /usr/local/share/vim /usr/bin/vim

  # Install pre-requisits
  sudo apt-get install git \
    ncurses-dev \
    python-dev \
    python3-dev \
    libncurses5-dev \
    libatk1.0-dev \
    libx11-dev \
    libxpm-dev \
    libxt-dev

  # Clone repo
  cd /usr/local/src
  if [[ ! -d vim ]]; then
    sudo git clone https://github.com/vim/vim
  fi

  # Update repo
  cd vim
  sudo git pull && sudo git fetch

  # In case Vim was already installed
  cd src
  sudo make distclean
  cd ..

  # Build and install vim
  sudo ./configure \
    --enable-multibyte \
    --enable-pythoninterp=dynamic \
    --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
    --enable-python3interp \
    --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
    --enable-cscope \
    --enable-gui=auto \
    --with-features=huge \
    --with-x \
    --enable-fontset \
    --enable-largefile \
    --disable-netbeans \
    --enable-fail-if-missing
  sudo make && sudo make install
}

setup_vim() {
  # Install vim
  echo "Installing vim ..."
  # sudo apt-get install vim-nox -y -qq
  install_vim

  # Install vim plugins
  echo "Installing vim plugins ..."
  git submodule init
  git submodule update
  vim -c VundleInstall -c quitall
  "$HOME/.vim/bundle/fzf/install" --all

  # Build YouCompleteMe
  cd "$HOME/.vim/bundle/YouCompleteMe"
  ./install.py --clang-completer

  return 0;
}

setup() {
  git_config

  # install_dev_pkgs
  # install_desktop_pkgs
  # install_user_pkgs

  # wget https://s3.amazonaws.com/tunnelbear/linux/openvpn.zip
  # sudo nmcli connection import type openvpn file TunnelBear\ Hong\ Kong.ovpn
  # ...

  setup_dotfiles
  # setup_vim
  # echo "Done! :)"
}

# MAIN
setup
