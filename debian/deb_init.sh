#!/bin/sh

ln -fs $PWD/configs/sudoers /etc/sudoers
ln -fs $PWD/configs/sources.list /etc/apt/sources.list

apt-get update
cat deb.pkgs | xargs apt-get install -y

# rm -rf Desktop
# rm -rf Documents
# rm -rf Downloads
# rm -rf Videos
# rm -rf Pictures
# rm -rf Public
# rm -rf Templates
