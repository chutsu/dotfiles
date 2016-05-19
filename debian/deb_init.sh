#!/bin/sh
BASEDIR=$(dirname $0)

# ln -fs $BASEDIR/configs/sudoers /etc/sudoers
# ln -fs $BASEDIR/configs/sources.list /etc/apt/sources.list

# apt-get update
grep -v '^#' $BASEDIR/deb.pkgs | xargs apt-get install -y

rm -rf Desktop
rm -rf Documents
rm -rf Downloads
rm -rf Videos
rm -rf Pictures
rm -rf Public
rm -rf Templates
