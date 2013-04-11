# workout what OS shell is running on
case $( uname -s ) in
Linux)
    OS="LINUX"
    ;;
Darwin)
    OS="MAC"
    ;;
esac

# Dir shortcuts
export DROPBOX="$HOME/Dropbox"
alias dotfiles="cd $DROPBOX/proj/dotfiles";
alias p="cd $DROPBOX/proj/";
alias scripts="cd $DROPBOX/proj/scripts"

# Executional shortcuts
if [ "$OS" = "LINUX" ]; then
    alias ls="ls -lh --color ";
elif [ "$OS" = "MAC" ]; then
    alias ls="ls -lh";
fi
alias v="vim";
alias vimrc="vim $HOME/.vimrc";
alias bashrc="vim $HOME/.bash_profile";
alias cc218="ssh -X cc218@cc218.host.cs.st-andrews.ac.uk"
alias bobbu="ssh -X chris@bobbu.cs.st-andrews.ac.uk"

alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop"
alias pg_restart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log restart"

# Environment settings
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:$HOME/Dropbox/proj/scripts
export PATH=/usr/local/share/python:$PATH
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH

# Shell settings
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
# eval `dircolors $HOME/Dropbox/dotfiles/shell_bundle/solarized/dircolors.256dark`
if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

function _update_ps1 {
    export PS1="$(~/Dropbox/proj/dotfiles/shell_bundle/powerline-shell/powerline-shell.py $?)"
}

export PROMPT_COMMAND="_update_ps1"
