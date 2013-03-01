# Dir shortcuts
alias p="cd $HOME/Dropbox/proj/";
alias dotfiles="cd $HOME/Dropbox/dotfiles";

# Executional shortcuts
alias ls="ls -h";
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
eval `dircolors $HOME/Dropbox/dotfiles/shell_bundle/solarized/dircolors.256dark`
