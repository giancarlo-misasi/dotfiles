#!/bin/bash

# backup existing shell configuration
mv ~/.zshrc ~/.zshrc.bak
touch ~/.zshrc

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
