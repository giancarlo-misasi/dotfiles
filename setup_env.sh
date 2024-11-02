#!/bin/bash

# update the package manager
apt-get -y update

# set timezone which may require a prompt
ENV TZ=America/Vancouver

# install basics
apt-get -y install tzdata zsh curl wget zip unzip git vim build-essential gcc g++ gdb

# switch to zsh
chsh -s $(which zsh)
