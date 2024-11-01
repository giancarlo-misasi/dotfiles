#!/bin/bash

# update the package manager
apt-get -y update

# install basics
apt-get -y install zsh curl wget zip unzip git vim build-essential gcc g++

# install mise for language and tool management
curl https://mise.run | sh
mise_use() {
    local tools=("$@")
    for tool in "${tools[@]}"; do
        mise use -g -f -y "$tool"
    done
}

# install tools
mise_use fzf ripgrep fd tree-sitter neovim

# install languages
mise_use lua rust go python java gradle node