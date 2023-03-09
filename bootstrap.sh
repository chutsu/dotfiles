#!/bin/bash
set -e

# Install Pre-requisits
sudo apt-get update -y -qq
sudo apt-get install curl sway waybar -y -qq

# Install Nix
# if ! command -v nix &> /dev/null; then
#   sh <(curl -L https://nixos.org/nix/install) --daemon
# fi

# Install packages
# nix-env -i neovim
# nix-env -i git
# nix-env -i tmux
# nix-env -i lazygit
# nix-env -i htop
# nix-env -i fzf
# nix-env -i vifm
# nix-env --uninstall gnumake
# nix-env --uninstall cmake
# nix-env --uninstall gcc
# nix-env --uninstall meson
# nix-env --uninstall qt5.full

# Clone projects
cd $HOME
mkdir -p projects
cd projects
# git clone git@github.com:chutsu/dotfiles.git
# git clone git@github.com:chutsu/proto.git
# git clone git@github.com:chutsu/proto_parts.git
# git clone git@github.com:chutsu/phd.git
# git clone git@github.com:chutsu/papers.git
cd $HOME
