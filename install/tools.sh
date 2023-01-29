#!/bin/zsh

begins_with() {
    case $2 in "$1"*) true;; *) false;; esac;
}

install_latest() {
    asdf plugin add $1 "https://github.com/$2.git"
    asdf install $1 latest
    asdf global $1 latest
}

# Make sure profile is loaded
source ~/.zshrc

# Install the SDKs
echo "Checking for SDKs"
which_asdf_result=$(which asdf)
if begins_with "asdf ()" "$which_asdf_result"; then
    install_latest rust asdf-community/asdf-rust
    cargo install ripgrep
    cargo install fd-find
    cargo install tree-sitter-cli

    install_latest python asdf-community/asdf-python
    install_latest ruby asdf-vm/asdf-ruby
    install_latest nodejs asdf-vm/asdf-nodejs
    install_latest lua Stratus3D/asdf-lua
    install_latest golang kennyp/asdf-golang
    install_latest neovim richin13/asdf-neovim
    nvim --headless +"Lazy! sync" +"TSUpdate"  +"qa"
else
    echo "ASDF not sourced, run ./install/tools.sh manually"
fi

# Install AWS Cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip -q awscliv2.zip && ./aws/install