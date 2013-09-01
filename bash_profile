#!/bin/bash
export TERM=xterm
# WHICH OS?
case $( uname -s ) in
Linux)
    OS="LINUX"
    ;;
Darwin)
    OS="MAC"
    ;;
esac

# DIR PATHS
export DROPBOX="$HOME/Dropbox"
export PROJECTS="$DROPBOX/proj"
export SCRIPTS="$PROJECTS/scripts"
export DOTFILES="$PROJECTS/dotfiles"

# DIR SHORTCUTS
alias dotfiles="cd $DOTFILES";
alias p="cd $PROJECTS";
alias toys="cd $PROJECTS/toys"
alias scripts="cd $SCRIPTS"
alias work="cd $DROPBOX/work"

alias websites="cd $PROJECTS/websites/"
alias domino="cd $PROJECTS/websites/domino"
alias chambers="cd $PROJECTS/websites/chambers"
alias chutsu="cd $PROJECTS/websites/chutsu.github.com"

alias membank="cd $PROJECTS/membank/"
alias notes="cd $PROJECTS/membank/notes"
alias papers="cd $PROJECTS/membank/papers"
alias docs="cd $PROJECTS/membank/docs"

# EXECUTIONAL SHORTCUTS
if [ $OS == LINUX ]; then
    alias ls="ls -lh --color"
    alias la="ls -lha --color"
elif [ $OS == MAC ]; then
    alias ls="ls -lh"
    alias la="ls -lha"
fi
alias c="cd "

alias v="vim";
alias vimrc="vim $HOME/.vimrc";
alias bashrc="vim $HOME/.bash_profile && source $HOME/.bash_profile";
alias cc218="ssh -X cc218@cc218.host.cs.st-andrews.ac.uk"
alias bobbu="ssh -X chris@bobbu.cs.st-andrews.ac.uk"

alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop"
alias pg_restart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log restart"


# ENVIRONMENTAL SETTINGS
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:$HOME/Dropbox/proj/scripts
export PATH=/usr/local/share/python:$PATH
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH
export PATH=$HOME/bin:$PATH
export VISUAL=vim
export EDITOR=vim


# SHELL SETTINGS
export HISTSIZE=1000000
export HISTFILESIZE=1000000000
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
# eval `dircolors $HOME/Dropbox/dotfiles/shell_bundle/solarized/dircolors.256dark`
if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

export PS1="[\w] > "
