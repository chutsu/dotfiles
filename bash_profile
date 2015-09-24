#!/bin/bash
export TERM=screen-256color
source ~/.fzf.bash


# WHICH OS?
case $( uname -s ) in
Linux)
    OS="LINUX"
    ;;
Darwin)
    OS="MAC"
    ;;
esac

# STARTX
if [ $OS == LINUX ] && [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ] && [ -z "$SSH_CONNECTION" ]; then
    [[ -z $DISPLAY && XDG_VTNR -eq 1 ]] && exec startx && xbindkeys && nm-applet
fi

# DIR PATHS
export DROPBOX="$HOME/Dropbox"
export PROJECTS="$DROPBOX/proj"
export DOTFILES="$PROJECTS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"

# DIR SHORTCUTS
alias down="cd ~/Downloads";
alias dotfiles="cd $DOTFILES";
alias p="cd $PROJECTS";
alias toys="cd $PROJECTS/toys"
alias scripts="cd $SCRIPTS"
alias work="cd $DROPBOX/work"

# websites
alias websites="cd $PROJECTS/websites/"
alias domino="cd $PROJECTS/websites/domino"
alias chamber="cd $PROJECTS/websites/chamber"
alias chutsu="cd $PROJECTS/websites/chutsu.github.com"
alias recall="cd $PROJECTS/websites/recall"

# membank
alias membank="cd $PROJECTS/membank/"
alias notes="cd $DROPBOX/notes; vim; cd -"
alias papers="cd $PROJECTS/membank/papers"
alias docs="cd $PROJECTS/membank/docs"

# projects
alias ids="cd $PROJECTS/ids/"
alias evolve="cd $PROJECTS/evolve"
alias al="cd $PROJECTS/al/"
alias munit="cd $PROJECTS/munit"
alias eyes="cd $PROJECTS/eyes"
alias playground="cd $PROJECTS/playground"
alias qfly="cd $PROJECTS/qfly"
alias prototype="cd $PROJECTS/prototype"
alias ditto="cd $PROJECTS/ditto"
alias wire="cd $PROJECTS/wire"
alias cog="cd $PROJECTS/cog"

alias sandbox="cd $DROPBOX/sandbox"
alias r2sams="cd $DROPBOX/sandbox/r2sams"

# GIT ALIASES
alias lg="git log --graph \
    --abbrev-commit \
    --decorate \
    --date=relative \
    --format=format:'%C(bold blue)%h%C(reset) \
    - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' \
    --all"


# EXECUTIONAL SHORTCUTS
if [ $OS == LINUX ]; then
    alias ls='ls -lh --group-directories-first --color'
    alias la='ls -lha --color'
    alias install='sudo apt-get install -y --force-yes'
    alias search='apt-cache search'
    alias update='sudo apt-get update'
    alias remove='sudo apt-get remove'
    alias purge='sudo apt-get purge'
elif [ $OS == MAC ]; then
    alias ls='ls -lh'
    alias la='ls -lha'
fi

alias vimrc="vim $HOME/.vimrc";
alias bashrc="vim $HOME/.bash_profile && source $HOME/.bash_profile";
alias todo="vim $DROPBOX/TODO";


# ENVIRONMENTAL SETTINGS
export PATH=$PATH:$PROJECTS/dotfiles/scripts
export VISUAL=vim
export EDITOR=vim


# SHELL SETTINGS
export HISTSIZE=1000000
export HISTFILESIZE=1000000000
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

export PS1="[\w] > "


# START TMUX ON BASH STARTUP
if [ $OS == "LINUX" ]; then
    if which tmux 2>&1 >/dev/null; then
        [[ -z "$TMUX" ]] && exec tmux -2 -f ~/.tmux.conf
    fi
fi
