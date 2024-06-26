#!/bin/bash

apt-get -y update
apt-get -y install zsh curl wget zip unzip git vim
apt-get -y install build-essential gcc g++ \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev \
    xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

brew update
brew upgrade
brew install neovim
brew install fzf ripgrep fd tree-sitter compiledb
brew install rust gdb go delve openjdk@17 gradle@7 lua

