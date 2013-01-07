# Dir shortcuts
alias p="cd $HOME/Dropbox/proj/";
alias dotfiles="cd $HOME/Dropbox/dotfiles";

# Executional shortcuts
alias ls="ls -h";
alias v="vim";
alias vimrc="vim ~/.vimrc";
alias bashrc="vim ~/.bash_profile";
alias remote="ssh -X cc218@cc218.host.cs.st-andrews.ac.uk"
alias server="ssh -X chutsu@chotsfu.com"

# Environment settings
export PATH=$PATH:$HOME/Dropbox/scripts

# Shell settings
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
eval `dircolors $HOME/Dropbox/dotfiles/shell_bundle/solarized/dircolors.256dark`
