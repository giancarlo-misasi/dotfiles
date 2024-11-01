#!/bin/bash

# update the package manager
apt-get -y update

# install basics
apt-get -y install zsh curl wget zip unzip git vim build-essential gcc g++

# switch to zsh
chsh -s $(which zsh)
