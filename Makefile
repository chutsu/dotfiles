help:
	@echo "\033[1;34m[make targets]:\033[0m"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; \
			{printf "\033[1;36m%-12s\033[0m%s\n", $$1, $$2}'

dotfiles: init bash_profile gitconfig gdbinit xdefaults nvim vifm sway tmux qutebrowser ## Install dotfiles

init:
	@mkdir -p ${HOME}/.config

bash_profile:
	@echo "- bash_profile"
	@rm -f ${HOME}/.bash_profile
	@ln -fs ${PWD}/configs/bash_profile ${HOME}/.bash_profile
	@echo "source ~/.bash_profile" >> "${HOME}/.bashrc";

gitconfig:
	@echo "- gitconfig"
	@rm -f ${HOME}/.gitconfig
	@ln -fs ${PWD}/configs/gitconfig ${HOME}/.gitconfig

gdbinit:
	@echo "- gdbinit"
	@rm -f ${HOME}/.gdbinit
	@ln -fs ${PWD}/configs/gdbinit ${HOME}/.gdbinit

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
		python3-pandas \
		python3-seaborn \
		python3-matplotlib \
		python3-setuptools

shell_pkgs:
	@sudo apt-get install -y -qq \
		shellcheck \
		silversearcher-ag

desktop_apps: install_neovim install_lazygit
	@echo "Install desktop_apps"
	@sudo apt-get install -y -qq \
		xterm \
		tilix \
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
		grim \
		slurp \
		wf-recorder \
		texlive-full \
		mplayer \
		vlc \
		sway \
		gimp

# NEOVIM
install_neovim:
	@curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	@sudo tar -C /usr/local/src -xzf nvim-linux64.tar.gz
	@sudo ln -sf /usr/local/src/nvim-linux64/bin/nvim /usr/local/bin/nvim
	@rm nvim-linux64.tar.gz

# LAZYGIT
LAZYGIT_VERSION=$(shell curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
install_lazygit:
	@curl -Lo lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_$(LAZYGIT_VERSION)_Linux_x86_64.tar.gz
	@tar xf lazygit.tar.gz lazygit
	@sudo install lazygit /usr/local/bin
	@rm lazygit.tar.gz lazygit


# PASS
/usr/local/src/password-store:
	@sudo git clone https://git.zx2c4.com/password-store /usr/local/src/password-store

install_pass: /usr/local/src/password-store
	@cd /usr/local/src/password-store && sudo make install


setup_projects:  # Setup projects
	@mkdir -p ${HOME}/projects
	@cd ${HOME}/projects && git clone git@github.com:chutsu/proto.git
	@cd ${HOME}/projects && git clone git@github.com:chutsu/proto_parts.git
	@cd ${HOME}/projects && git clone git@github.com:chutsu/proto_ros2.git
	@cd ${HOME}/projects && git clone git@github.com:chutsu/ros2_vicon.git
	@cd ${HOME}/projects && git clone git@github.com:chutsu/papers.git
	@cd ${HOME}/projects && git clone git@github.com:chutsu/coding_prep.git
	@cd ${HOME}/projects && git clone git@github.com:chutsu/phd_thesis.git
	@cd ${HOME}/projects && git clone git@github.com:chutsu/yac.git
	@cd ${HOME}/projects && git clone git@github.com:chutsu/chutsu.github.io.git

sync_projects:  # Sync projects
	@mkdir -p ${HOME}/projects
	@cd ${HOME}/projects/proto && git pull
	@cd ${HOME}/projects/proto_parts && git pull
	@cd ${HOME}/projects/proto_ros2 && git pull
	@cd ${HOME}/projects/ros2_vicon && git pull
	@cd ${HOME}/projects/papers && git pull
	@cd ${HOME}/projects/coding_prep && git pull
	@cd ${HOME}/projects/phd_thesis && git pull
	@cd ${HOME}/projects/yac && git pull
	@cd ${HOME}/projects/chutsu.github.io && git pull
