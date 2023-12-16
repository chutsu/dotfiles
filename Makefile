help:
	@echo "\033[1;34m[make targets]:\033[0m"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; \
			{printf "\033[1;36m%-12s\033[0m%s\n", $$1, $$2}'

dotfiles: bash_profile gitconfig xdefaults nvim vifm sway tmux qutebrowser ## Install dotfiles

bash_profile:
	@echo "- bash_profile"
	@rm -f ${HOME}/.bash_profile
	@ln -fs ${PWD}/configs/bash_profile ${HOME}/.bash_profile
	@echo "source ~/.bash_profile" >> "${HOME}/.bashrc";

gitconfig:
	@echo "- gitconfig"
	@rm -f ${HOME}/.gitconfig
	@ln -fs ${PWD}/configs/gitconfig ${HOME}/.gitconfig

xdefaults:
	@echo "- xdefaults"
	@rm -f ${HOME}/.Xdefaults
	@ln -fs ${PWD}/configs/Xdefaults ${HOME}/.Xdefaults

nvim:
	@echo "- nvim"
	@rm -rf ${HOME}/.config/nvim
	@ln -fs ${PWD}/configs/nvim ${HOME}/.config/nvim

vifm:
	@echo "- vifm"
	@rm -rf ${HOME}/.config/vifm
	@ln -fs ${PWD}/configs/vifm ${HOME}/.config/vifm

sway:
	@echo "- sway"
	@rm -rf ${HOME}/.config/sway
	@ln -fs ${PWD}/configs/sway ${HOME}/.config/sway

tmux:
	@echo "- tmux"
	@rm -f ${HOME}/.tmux.config
	@rm -f ${HOME}/.config/tmux
	@ln -fs ${PWD}/configs/tmux ${HOME}/.config/tmux

qutebrowser:
	@echo "- qutebrowser"
	@rm -rf ${HOME}/.config/qutebrowser
	@ln -fs ${PWD}/configs/qutebrowser ${HOME}/.config/qutebrowser


deps: dev_pkgs cpp_pkgs python_pkgs shell_pkgs desktop_apps ## Install dependencies

dev_pkgs:
	@echo "Install dev packages"
	@sudo apt-get install -y -qq \
		xterm \
		curl \
		git \
		tree \
		htop \
		tmux \
		gnuplot \
		openssh-server

cpp_pkgs:
	@echo "Install C / C++ packages"
	@sudo apt-get install -y -qq \
		exuberant-ctags \
		automake \
		cmake \
		ccache \
		gcc \
		clang \
		clang-format \
		clang-tidy

python_pkgs:
	@echo "Install python packages"
	@sudo apt-get install -y -qq \
		libpython3-dev \
		pylint \
		yapf3 \
		python3-pip \
		python3-numpy \
		python3-scipy \
		python3-matplotlib \
		python3-setuptools

shell_pkgs:
	@sudo apt-get install -y -qq \
		shellcheck \
		silversearcher-ag

desktop_apps:
	@echo "Install desktop_apps"
	@sudo apt-get install -y -qq \
		xterm \
		vifm \
		xinit \
		xbacklight \
		network-manager-gnome \
		pcmanfm \
		gnome-icon-theme \
		pavucontrol \
		arandr \
		bluetooth bluez bluez-tools rfkill blueman \
		vokoscreen \
		gimp \
		mplayer \
		vlc \

# NEOVIM
/usr/local/src/neovim:
	@sudo git clone https://github.com/neovim/neovim /usr/local/src/neovim

install_nvim: /usr/local/src/neovim
	@sudo apt-get install -y -qq gettext
	@cd /usr/local/src/neovim \
		&& sudo make CMAKE_BUILD_TYPE=RelWithDebInfo \
		&& sudo make install

# SWAY
install_sway:
	@sudo apt-get install sway -y -qqq

# PASS
/usr/local/src/password-store:
	@sudo git clone https://git.zx2c4.com/password-store /usr/local/src/password-store

install_pass: /usr/local/src/password-store
	@cd /usr/local/src/password-store && sudo make install

# LAZYGIT
LAZYGIT_VERSION := $(shell curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
install_lazygit:
	@curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_$(LAZYGIT_VERSION)_Linux_x86_64.tar.gz"
	@tar xf lazygit.tar.gz lazygit
	@sudo mv lazygit /usr/local/bin
	@rm lazygit.tar.gz
