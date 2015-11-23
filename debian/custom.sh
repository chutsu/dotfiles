#!/bin/sh

DOWNLOADS_PATH=~/downloads


# check if running as root
if [ $(whoami) != "root" ]; then
    echo "you must run this script with sudo!"
    exit -1
fi


setup_dirs()
{
    mkdir -p $DOWNLOADS_PATH
}

install_firefox()
{
    FIREFOX_FILENAME="firefox.tar.bz2"

    # download firefox
    echo "downloading firefox"
    wget \
        -q \
        "https://download.mozilla.org/?product=firefox-42.0-SSL&os=linux64&lang=en-US" \
        -O $DOWNLOADS_PATH/$FIREFOX_FILENAME

    # extract and install
    echo "installing firefox"
    cd $DOWNLOADS_PATH
    tar -xf $FIREFOX_FILENAME
    rm -rf /usr/local/src/firefox
    mkdir -p /usr/local/src
    cp -R firefox /usr/local/src
    ln -fs /usr/local/src/firefox/firefox /usr/local/bin/firefox

    echo "firefox installed"
}

install_dropbox()
{
    # download and extract
    cd ~
    wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
    ~/.dropbox-dist/dropboxd &
}


setup_dirs
# install_firefox
# install_dropbox
