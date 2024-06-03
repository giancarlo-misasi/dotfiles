#!/bin/bash

apt-get -y update
apt-get -y install zsh curl wget zip unzip git vim
apt-get -y install build-essential gcc g++ \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev \
    xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

brew update
brew upgrade
brew install neovim
brew install fzf ripgrep fd compiledb
brew install rust go delve java gradle lua
cargo install tree-sitter-cli

