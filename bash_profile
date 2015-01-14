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
    [[ -z $DISPLAY && XDG_VTNR -eq 1 ]] && exec startx
fi

# DIR PATHS
export DROPBOX="$HOME/Dropbox"
export PROJECTS="$DROPBOX/proj"
export SCRIPTS="$PROJECTS/scripts"
export DOTFILES="$PROJECTS/dotfiles"

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
alias notes="cd $DROPBOX/notes; vim $DROPBOX/notes; cd -;"
alias papers="cd $PROJECTS/membank/papers"
alias docs="cd $PROJECTS/membank/docs"

# projects
alias ids="cd $PROJECTS/toys/ids/"
alias evolve="cd $PROJECTS/toys/evolve"
alias al="cd $PROJECTS/toys/al/"
alias munit="cd $PROJECTS/toys/munit"
alias dbg="cd $PROJECTS/toys/dbg"
alias dstruct="cd $PROJECTS/toys/dstruct"
alias eyes="cd $PROJECTS/toys/eyes"
alias bowtie="cd $PROJECTS/toys/bowtie"
alias playground="cd $PROJECTS/toys/playground"
alias qfly="cd $PROJECTS/toys/qfly"
alias prototype="cd $PROJECTS/toys/prototype"
alias ditto="cd $PROJECTS/toys/ditto"
alias wire="cd $PROJECTS/toys/wire"

alias audi2="cd ~/cask/spikes/audi2/"

# folders
alias cask="cd ~/cask"


# EXECUTIONAL SHORTCUTS
if [ $OS == LINUX ]; then
    alias ls='ls -lh --group-directories-first --color'
    alias la='ls -lha --color'
elif [ $OS == MAC ]; then
    alias ls='ls -lh'
    alias la='ls -lha'
fi

alias vimrc="vim $HOME/.vimrc; source $HOME/.vimrc";
alias bashrc="vim $HOME/.bash_profile && source $HOME/.bash_profile";
alias todo="vim $DROPBOX/TODO";
alias cc218="ssh -X cc218@cc218.host.cs.st-andrews.ac.uk"

alias pg_start="pg_ctl -D /usr/local/var/postgres9.3 -l /usr/local/var/postgres9.3/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres9.3 -l /usr/local/var/postgres9.3/server.log stop"
alias pg_restart="pg_ctl -D /usr/local/var/postgres9.3 -l /usr/local/var/postgres9.3/server.log restart"

if [ $OS == MAC ]; then
    export PATH="$PATH:/usr/local/CrossPack-AVR/bin/";
    export JAVA_HOME="$(/usr/libexec/java_home)";
fi

# ENVIRONMENTAL SETTINGS
export GDK_USE_XFT=1
export QT_XFT=true

export PATH=/usr/local/bin:/usr/texbin:$PATH
export PATH=$PATH:$HOME/Dropbox/proj/scripts
export PATH=$PATH:$HOME/Dropbox/proj/dotfiles/scripts
export PATH=/usr/local/share/python:$PATH
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/sbin:$PATH
export PATH=$HOME/.gem/ruby/2.1.0/bin:$PATH
export PATH=$HOME/pebble-dev/PebbleSDK-2.8.1/bin:$PATH
export VISUAL=vim
export EDITOR=vim

export PATH=$DROPBOX/cask:$PATH

if [ $OS == MAC ]; then
    export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages

    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi

    # HADOOP
    export HADOOP_OPTS="-Djava.security.krb5.realm=OX.AC.UK -Djava.security.krb5.kdc=kdc0.ox.ac.uk:kdc1.ox.ac.uk"
    export HADOOP_HOME=/usr/local/bin/hadoop
fi


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
