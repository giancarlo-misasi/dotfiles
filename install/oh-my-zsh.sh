#!/bin/bash

# Make sure prompt string is passed in
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 PROFILE_PROMPT_PREFIX" >&2
  exit 1
fi

# Install OH-MY-ZSH
echo "Checking for OH-MY-ZSH"
if ! [ -d $HOME/.oh-my-zsh ]; then
    echo "Installing OH-MY-ZSH"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    sed -i 's/plugins=(git)/plugins=(git asdf vscode docker aws)/' $HOME/.zshrc
    echo "export PROFILE_PROMPT_PREFIX=$1" >> $HOME/.zshrc
    echo "source $HOME/.config/nvim/install/.zshrc-customizations" >> $HOME/.zshrc
fi