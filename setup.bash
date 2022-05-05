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
    mplayer \
    vlc

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

  # Vifm
  pip3 install ueberzug
  $APT_INSTALL ffmpegthumbnailer

  # Nvim - vim-plug
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

install_desktop_pkgs() {
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
    bluetooth bluez bluez-tools rfkill blueman


  $APT_INSTALL \
    vokoscreen \
    vlc

  $APT_INSTALL \
    texlive-*
}

setup_dotfiles() {
  # REMOVE OLD DOTFILES
  echo "remove old dotfiles";
  rm -f "${HOME}/.bash_profile";
  rm -rf "${HOME}/.gitconfig";
  rm -f "${HOME}/.xbindkeysrc";
  rm -f "${HOME}/.Xdefaults";
  rm -f "${HOME}/.xinitrc";
  rm -f "${HOME}/.xsessionrc";
  rm -rf "${HOME}/.configs/.i3";
  rm -f "${HOME}/.configs/nvim";
  rm -f "${HOME}/.screenlayout";
  rm -f "${HOME}/.tmux.conf";
  rm -rf "${HOME}/.vifm";
  rm -f "${HOME}/.vifmrc";

  # SYMLINKS
  echo "symlinks dotfiles";
  ln -fs "${PWD}/configs/bash_profile" "${HOME}/.bash_profile";
  ln -fs "${PWD}/configs/gitconfig" "${HOME}/.gitconfig";
  ln -fs "${PWD}/configs/inputrc" "${HOME}/.inputrc";
  ln -fs "${PWD}/configs/latexmkrc" "${HOME}/.latexmkrc";
  ln -fs "${PWD}/configs/xbindkeysrc" "${HOME}/.xbindkeysrc";
  ln -fs "${PWD}/configs/Xdefaults" "${HOME}/.Xdefaults";
  ln -fs "${PWD}/configs/xinitrc" "${HOME}/.xinitrc";
  ln -fs "${PWD}/configs/xsessionrc" "${HOME}/.xsessionrc";
  ln -fs "${PWD}/i3" "${HOME}/.config/";
  ln -fs "${PWD}/nvim" "${HOME}/.config/";
  ln -fs "${PWD}/screenlayout" "${HOME}/.screenlayout";
  ln -fs "${PWD}/tmux/tmux.conf" "${HOME}/.tmux.conf";
  ln -fs "${PWD}/vifm" "${HOME}/.vifm";
  ln -fs "${PWD}/vifm/vifmrc" "${HOME}/.vifmrc";
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
  sudo apt-get update
  install_dev_pkgs;

  if [ "$MODE" == "full" ]; then
    install_desktop_pkgs;
  fi

  setup_dotfiles;
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
