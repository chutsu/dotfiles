#!/bin/sh
set -e  # halt on first error

show_usage()
{
  echo "Usage: unpack <archived / compressed file>"
  echo "supports: gz, tgz, xz, bz2, tar, rar, zip"
}


# MAIN
if [ "$#" -ne 1 ]; then
  show_usage
  exit 1
fi

FILENAME=$(basename "$1")
EXT="${FILENAME##*.}"
echo "unpacking archive [$EXT]"

case "$EXT" in
  gz) tar -xzvf "$1";;
  tgz) tar -xzvf "$1";;
  xz) tar -xzvf "$1";;
  bz2) tar -xvjpf "$1";;
  tar) tar -xvf "$1";;
  rar) unrar e "$1";;
  zip) unzip "$1";;
esac

echo "done! :)"
