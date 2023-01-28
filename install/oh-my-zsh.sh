#!/bin/bash

# Install OH-MY-ZSH
echo "Checking for OH-MY-ZSH"
if ! [ -d ~/.oh-my-zsh ]; then
    echo "Installing OH-MY-ZSH"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    sed -i 's/plugins=(git)/plugins=(git asdf vscode docker aws)/' ~/.zshrc
fi