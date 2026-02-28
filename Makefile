MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(patsubst %/,%,$(dir $(MKFILE_PATH)))
PREFIX := $(MKFILE_DIR)/third_party
SRC_PATH := $(PREFIX)/src
LOG_PATH := $(PREFIX)/log
NUM_PROCS := $(shell expr `nproc` / 2)

NEOVIM_REPO=https://github.com/neovim/neovim
NEOVIM_VERSION=0.11.6
BTOP_REPO=https://github.com/aristocratos/btop
BTOP_VERSION=v1.4.6

define get_repo_name
$(basename $(notdir $(patsubst %/,%,$(1))))
endef

define git_clone
	@( \
	if [ ! -d "$(SRC_PATH)/$(call get_repo_name,$(1))" ]; then \
		cd $(SRC_PATH) && git clone $(1); \
	fi \
	|| cd $(SRC_PATH)/$(call get_repo_name,$(1)) git checkout $(2) \
	) > "$(LOG_PATH)/$(call get_repo_name,$(1)).log" 2>&1
endef

define cmake_build
	@echo "Building [$(1)] ..."
	@( \
	cd $(SRC_PATH)/$(1) \
		&& mkdir -p build \
		&& cd build || return \
		&& cmake \
			-DCMAKE_COLOR_MAKEFILE=OFF \
			-DCMAKE_BUILD_TYPE=Release \
			-DCMAKE_PREFIX_PATH=$(PREFIX) \
			-DCMAKE_INSTALL_PREFIX=$(PREFIX) \
			.. \
		&& make -j$(NUM_PROCS) \
		&& make install; \
	) > "$(LOG_PATH)/$(1).log" 2>&1
endef

help:
	@echo "\033[1;34m[make targets]:\033[0m"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; \
			{printf "\033[1;36m%-12s\033[0m%s\n", $$1, $$2}'

dotfiles:  ## Install dotfiles
	# Initialize
	@mkdir -p ${HOME}/.config

	# bash_profile
	@echo "- bash_profile"
	@rm -f ${HOME}/.bash_profile
	@ln -fs ${PWD}/configs/bash_profile ${HOME}/.bash_profile
	@echo "source ~/.bash_profile" >> "${HOME}/.bashrc";

	# gitconfig
	@echo "- gitconfig"
	@rm -f ${HOME}/.gitconfig
	@ln -fs ${PWD}/configs/gitconfig ${HOME}/.gitconfig

	# gdbinit
	@echo "- gdbinit"
	@rm -f ${HOME}/.gdbinit
	@ln -fs ${PWD}/configs/gdbinit ${HOME}/.gdbinit

	# xdefaults
	@echo "- xdefaults"
	@rm -f ${HOME}/.Xdefaults
	@ln -fs ${PWD}/configs/Xdefaults ${HOME}/.Xdefaults

	# nvim
	@echo "- nvim"
	@rm -rf ${HOME}/.config/nvim
	@ln -fs ${PWD}/configs/nvim ${HOME}/.config/nvim

	# vifm
	@echo "- vifm"
	@rm -rf ${HOME}/.config/vifm
	@ln -fs ${PWD}/configs/vifm ${HOME}/.config/vifm

	# sway
	@echo "- sway"
	@rm -rf ${HOME}/.config/sway
	@ln -fs ${PWD}/configs/sway ${HOME}/.config/sway

	# tmux
	@echo "- tmux"
	@rm -f ${HOME}/.tmux.config
	@rm -f ${HOME}/.config/tmux
	@ln -fs ${PWD}/configs/tmux ${HOME}/.config/tmux

deps: dev_pkgs cpp_pkgs shell_pkgs desktop_apps ## Install dependencies

dev_pkgs:
	@echo "Install dev packages"
	@sudo apt-get install -y -qq \
		xterm \
		curl \
		git \
		tree \
		htop \
		vifm \
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

shell_pkgs:
	@sudo apt-get install -y -qq \
		shellcheck \
		silversearcher-ag

desktop_apps: install_neovim
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
		grim \
		slurp \
		wf-recorder \
		texlive-full \
		mplayer \
		vlc \
		sway \
		gimp
	@sudo apt-get install -yqq snapd
	@sudo snap install btop

setup:
	@mkdir -p $(PREFIX)/bin
	@mkdir -p $(PREFIX)/include
	@mkdir -p $(PREFIX)/lib
	@mkdir -p $(PREFIX)/log
	@mkdir -p $(PREFIX)/share
	@mkdir -p $(PREFIX)/src

clean: ## Clean
	@rm -rf $(PREFIX)/bin
	@rm -rf $(PREFIX)/include
	@rm -rf $(PREFIX)/lib
	@rm -rf $(PREFIX)/log
	@rm -rf $(PREFIX)/share
	@rm -rf $(PREFIX)/src

# NEOVIM
install_neovim: setup
	$(call git_clone,$(NEOVIM_REPO),$(NEOVIM_VERSION))
	@cd $(PREFIX)/src/neovim \
		&& make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$(PREFIX) \
		&& make install
