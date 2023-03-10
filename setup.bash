#/bin/bash
set -e  # Exit on first error
APT_INSTALL='sudo apt-get install -y -qq'

install_dev_pkgs() {
  # General dev tools
  $APT_INSTALL \
    xterm \
    curl \
    git \
    tree \
    htop \
    tmux \
    neovim \
    gimp \
    gnuplot \
    mplayer \
    vlc \
    openssh-server

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

  # Python
  $APT_INSTALL \
    libpython3-dev \
    pylint \
    yapf3 \
    python3-pip \
    python3-numpy \
    python3-scipy \
    python3-matplotlib \
    python3-setuptools \

  # Sh / Bash
  $APT_INSTALL \
    shellcheck \
    silversearcher-ag

  # Apps
  $APT_INSTALL \
    xterm \
    vifm \
    i3 \
    xinit \
    xbacklight \
    network-manager-gnome \
    pcmanfm \
    gnome-icon-theme \
    pavucontrol \
    arandr \
    bluetooth bluez bluez-tools rfkill blueman \
    vokoscreen \
    vlc
}

setup_dotfiles() {
  # REMOVE OLD DOTFILES
  echo "remove old dotfiles";
  rm -f "${HOME}/.bash_profile";
  rm -rf "${HOME}/.gitconfig";
  #rm -f "${HOME}/.xbindkeysrc";
  rm -f "${HOME}/.Xdefaults";
  #rm -f "${HOME}/.xinitrc";
  #rm -f "${HOME}/.xsessionrc";
  #rm -f "${HOME}/.configs/nvim";
  rm -f "${HOME}/.tmux.conf";
  rm -rf "${HOME}/.vifm";
  rm -f "${HOME}/.vifmrc";

  # SYMLINKS
  echo "symlinks dotfiles";
  ln -fs "${PWD}/configs/bash_profile" "${HOME}/.bash_profile";
  ln -fs "${PWD}/configs/gitconfig" "${HOME}/.gitconfig";
  #ln -fs "${PWD}/configs/inputrc" "${HOME}/.inputrc";
  #ln -fs "${PWD}/configs/latexmkrc" "${HOME}/.latexmkrc";
  #ln -fs "${PWD}/configs/xbindkeysrc" "${HOME}/.xbindkeysrc";
  ln -fs "${PWD}/configs/Xdefaults" "${HOME}/.Xdefaults";
  #ln -fs "${PWD}/configs/xinitrc" "${HOME}/.xinitrc";
  #ln -fs "${PWD}/configs/xsessionrc" "${HOME}/.xsessionrc";
  mkdir -p ${HOME}/.config/nvim && ln -fs "${PWD}/configs/nvim.lua" "${HOME}/.config/init.lua";
  ln -fs "${PWD}/configs/tmux.conf" "${HOME}/.tmux.conf";
  #ln -fs "${PWD}/vifm" "${HOME}/.vifm";
  echo "source ~/.bash_profile" >> "${HOME}/.bashrc";
}

git_config() {
  git config --global user.name "Chris Choi";
  git config --global user.email "chutsu@gmail.com";
  git config --global push.default matching;
}

setup() {
  MODE=$1;
  git_config;
  install_dev_pkgs;
  setup_dotfiles;
  echo "Done! :)"
}

# MAIN
setup
