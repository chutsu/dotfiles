#!/bin/sh
TARGET=$HOME/Dropbox/proj/

echo "Downloading git projects from github"
mkdir -p $TARGET
cd TARGET
git clone git@github.com:chutsu/domino.git
git clone git@github.com:chutsu/scripts.git
git clone git@github.com:chutsu/sim.git
git clone git@github.com:chutsu/nut.git
git clone git@github.com:chutsu/munit.git
git clone git@github.com:chutsu/liddell.git
git clone git@github.com:chutsu/dbench.git
git clone git@github.com:chutsu/dataviz.git
git clone git@github.com:chutsu/mineview.git
git clone git@github.com:chutsu/membank.git
