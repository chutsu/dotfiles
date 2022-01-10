#/bin/bash
set -e  # Exit on first error
APT_INSTALL='sudo apt-get install -y -qq'

install_dev_pkgs() {
  # General dev tools
  $APT_INSTALL \
    xterm \
    git \
    tree \
    htop \
    tmux \
    neovim
}

install_cpp_pkgs() {
  # C / C++
  $APT_INSTALL \
    exuberant-ctags \
    automake \
    cmake \
    ccache \
    gcc \
    clang \
    clang-format \
    clang-tidy
}

install_octave_pkgs() {
  $APT_INSTALL octave-*
}

install_python_pkgs() {
  # Python
  $APT_INSTALL \
    libpython3-dev \
    python3-pip \
    python3-numpy \
    python3-scipy \
    python3-matplotlib \
    python3-setuptools

  pip3 install ueberzug
}

install_bash_pkgs() {
  # Sh / Bash
  $APT_INSTALL \
    shellcheck \
    silversearcher-ag
}

install_desktop_pkgs() {
  $APT_INSTALL \
    xterm \
    i3 \
    xinit \
    xbacklight \
    network-manager-gnome \
    pcmanfm \
    gnome-icon-theme \
    pavucontrol \
    arandr \
    bluetooth bluez bluez-tools rfkill blueman


  $APT_INSTALL \
    vokoscreen \
    vlc

  $APT_INSTALL \
    texlive-*
}

git_config() {
  git config --global user.name "Chris Choi";
  git config --global user.email "chutsu@gmail.com";
  git config --global push.default matching;
}

setup_dotfiles() {
  # REMOVE OLD DOTFILES
  echo "remove old dotfiles";
  rm -rf "${HOME}/.vim";
  rm -f "${HOME}/.vimrc";
  rm -f "${HOME}/.vifm";
  rm -f "${HOME}/.vifmrc";
  rm -f "${HOME}/.bash_profile";
  rm -f "${HOME}/.tmux.conf";
  rm -rf "${HOME}/.i3";
  rm -f "${HOME}/.xinitrc";
  rm -f "${HOME}/.Xdefaults";
  rm -f "${HOME}/.muttrc";
  rm -rf "${HOME}/.mutt";
  rm -f "${HOME}/.xbindkeysrc";
  rm -f "${HOME}/.screenlayout";
  rm -rf "${HOME}/.gitconfig";

  # SYMLINKS
  echo "symlinks dotfiles";
  ln -fs "${PWD}/vim" "${HOME}/.vim";
  ln -fs "${PWD}/vim/vimrc" "${HOME}/.vimrc";
  ln -fs "${PWD}/vifm" "${HOME}/.vifm";
  ln -fs "${PWD}/vifm/vifmrc" "${HOME}/.vifmrc";
  ln -fs "${PWD}/tmux/tmux.conf" "${HOME}/.tmux.conf";
  ln -fs "${PWD}/i3" "${HOME}/.config/";
  ln -fs "${PWD}/configs/bash_profile" "${HOME}/.bash_profile";
  ln -fs "${PWD}/configs/gitconfig" "${HOME}/.gitconfig";
  ln -fs "${PWD}/configs/inputrc" "${HOME}/.inputrc";
  ln -fs "${PWD}/configs/latexmkrc" "${HOME}/.latexmkrc";
  ln -fs "${PWD}/configs/xbindkeysrc" "${HOME}/.xbindkeysrc";
  ln -fs "${PWD}/configs/Xdefaults" "${HOME}/.Xdefaults";
  ln -fs "${PWD}/configs/xinitrc" "${HOME}/.xinitrc";
  echo "source ~/.bash_profile" >> "${HOME}/.bashrc";
  ln -fs "${PWD}/screenlayout" "${HOME}/.screenlayout";
}

install_vim() {
  # Remove existing vim installation
  sudo apt-get remove -y --purge \
    vim \
    vim-runtime \
    vim-gnome \
    vim-tiny \
    vim-gui-common
  sudo rm -rf /usr/local/share/vim /usr/bin/vim

  # Install pre-requisits
  $APT_INSTALL \
    git \
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

  # Build and install vim
  sudo ./configure \
    --enable-multibyte \
    --enable-python3interp=yes \
    --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu \
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
  cd "$HOME/dotfiles"
  vim -c VundleInstall -c quitall
  "$HOME/.vim/bundle/fzf/install" --all

  # Build YouCompleteMe
  cd "$HOME/.vim/bundle/YouCompleteMe"
  ./install.py --clang-completer
}

setup() {
  MODE=$1;
  git_config;
  install_dev_pkgs;
  install_cpp_pkgs;
  install_octave_pkgs;
  install_bash_pkgs;

  if [ "$MODE" == "full" ]; then
    install_python_pkgs;
    install_desktop_pkgs;
  fi

  setup_dotfiles;
  # setup_vim;
  echo "Done! :)"
}

print_usage() {
  echo "setup.bash [full | mini]"
}

# MAIN
if [ "$#" != "1" ]; then
  print_usage;
  exit;
fi
setup "${1}"
