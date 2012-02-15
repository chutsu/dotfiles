#!/bin/sh
git submodule add $1 vim/bundle/$2
git submodule init && git submodule update
