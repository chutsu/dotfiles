#!/bin/bash
set -e

# download and extract vim
curl ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2 -o vim-7.3.tar.bz2
tar -xvjpf vim-7.3.tar.bz2

# apply patch
patch vim73/runtime/tools/efm_perl.pl \
    -i misc_files/fix-charenc-efm_perl.pl-7.3.608.patch \
    -o vim73/runtime/tools/efm_perl.pl.patched
mv vim73/runtime/tools/efm_perl.pl.patched vim73/runtime/tools/efm_perl.pl

# configure, make and install
cd vim73
./configure \
    --enable-python3interp=yes \
    --enable-pythoninterp=yes \
    --enable-cscope \
    --with-features=big
make
sudo make install
cd -

# clear up
rm -rf vim73
rm vim-7.3.tar.bz2
