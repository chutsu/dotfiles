#!/bin/bash
export TERM=xterm

# START TMUX ON BASH STARTUP
if which tmux 2>&1 >/dev/null; then
    [[ -z "$TMUX" ]] && exec tmux -2
fi

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

# membank
alias membank="cd $PROJECTS/membank/"
alias notes="cd $PROJECTS/membank/notes"
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


# EXECUTIONAL SHORTCUTS
if [ $OS == LINUX ]; then
    alias ls='ls -lh --color'
    alias la='ls -lha --color'
elif [ $OS == MAC ]; then
    alias ls='ls -lh'
    alias la='ls -lha'
fi
alias c="cd "

alias v="vim";
alias vimrc="vim $HOME/.vimrc";
alias bashrc="vim $HOME/.bash_profile && source $HOME/.bash_profile";
alias cc218="ssh -X cc218@cc218.host.cs.st-andrews.ac.uk"
alias bobbu="ssh -X chris@bobbu.cs.st-andrews.ac.uk"

alias pg_start="pg_ctl -D /usr/local/var/postgres9.3 -l /usr/local/var/postgres9.3/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres9.3 -l /usr/local/var/postgres9.3/server.log stop"
alias pg_restart="pg_ctl -D /usr/local/var/postgres9.3 -l /usr/local/var/postgres9.3/server.log restart"

if [ $OS == MAC ]; then
    # alias cmake="cmake -DCMAKE_USER_MAKE_RULES_OVERRIDE=~/.cmake/cmake_rules.txt";
    alias cmake="cmake"
    # alias valgrind="valgrind --suppressions=/Users/chutsu/tools/custom.supp --error-exitcode=2 ";
    export PATH=$PATH:/usr/local/CrossPack-AVR/bin/
    # export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages/
fi

# ENVIRONMENTAL SETTINGS
export PATH=/usr/local/bin:/usr/texbin:$PATH
export PATH=$PATH:$HOME/Dropbox/proj/scripts
export PATH=/usr/local/share/python:$PATH
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/sbin:$PATH
export VISUAL=vim
export EDITOR=vim
# export LD_LIBRARY_PATH=/home/chutsu/Downloads/V-REP_PRO_EDU_V3_0_4_64_Linux:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib/:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=/usr/lib/OGRE/:$LD_LIBRARY_PATH

# if [ $OS == MAC ]; then
    # export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH
    # export PATH=/usr/X11/bin:$PATH

    # export CLANG_PATH="/Users/chutsu/third_party/llvm-build/Release+Asserts";
    # export CLANG_PATH="/Users/chutsu/tools/llvm/build/Release+Asserts";
    # export CC=$CLANG_PATH"/bin/clang";
    # export CXX=$CLANG_PATH"/bin/clang++";
    # export DYLD_FALLBACK_LIBRARY_PATH=$CLANG_PATH/lib/;
    # export DYLD_FALLBACK_LIBRARY_PATH=$CLANG_PATH/clang/3.4/lib/darwin/;
    # export PATH=$PATH:$HOME/tools/checker-275
# fi


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
