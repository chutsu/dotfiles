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
alias scripts="cd $SCRIPTS"

# EXECUTIONAL SHORTCUTS
alias v="vim";
alias vimrc="vim $HOME/.vimrc";
alias bashrc="vim $HOME/.bash_profile";
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

# SHELL SETTINGS
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
# eval `dircolors $HOME/Dropbox/dotfiles/shell_bundle/solarized/dircolors.256dark`
if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

function _update_ps1 {
    POWERLINE_SHELL_SCRIPT="$DOTFILES/shell_bundle/powerline-shell/powerline-shell.py"
    if [ -f $POWERLINE_SHELL_SCRIPT ];
    then
        export PS1="$($POWERLINE_SHELL_SCRIPT $?)"
    else
        echo $POWERLINE_SHELL_SCRIPT
        echo "can't find powerline shell script"
    fi
}

export PROMPT_COMMAND="_update_ps1"
