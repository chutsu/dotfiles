# Dir shortcuts
alias uni="cd $HOME/uni";
alias lp="cd $HOME/uni/lp";
alias wt="cd $HOME/uni/wt";

alias p="cd $HOME/proj/";
alias dotfiles="cd $HOME/Documents/dotfiles";
alias s="cd $HOME/Sites/";
alias chotsfu="cd $HOME/Sites/chotsfu/"

# Executional shortcuts
alias ls="ls -h";
alias v="vim";
alias vimrc="vim ~/.vimrc";
alias bashrc="vim ~/.bash_profile";
alias remote="ssh -X cc218@cc218.host.cs.st-andrews.ac.uk"
alias server="ssh -X chutsu@chotsfu.com"
alias python="python2.7"

# Environment settings
export PATH=$PATH:$HOME/Documents/scripts
export PATH=$PATH:/usr/local/mysql-5.5.24-osx10.6-x86_64/bin
export C_INCLUDE_PATH=/opt/local/include
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib # so that MySQLdb python package can find libmysqlclient.18.dylib



# Shell settings
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# MacPorts Installer addition on 2011-11-27_at_00:03:26: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
#export DYLD_LIBRARY_PATH=/opt/local/lib:/usr/lib
# Finished adapting your PATH environment variable for use with MacPorts.
