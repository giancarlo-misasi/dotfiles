#!/bin/zsh

add_to_default_cargo_crate() {
    echo "$1" >> ~/.default-cargo-crates
}

begins_with() {
    case $2 in "$1"*) true;; *) false;; esac;
}

install_latest() {
    asdf plugin add $1 "https://github.com/$2.git"
    asdf install $1 latest
    asdf global $1 latest
}

# Make sure the profile is sourced

# Setup default cargo crates
echo "Checking for default rust crates"
if ! [ -d ~/.default-cargo-crates ]; then
    echo "Setting up default rust crates"
    touch ~/.default-cargo-crates
    add_to_default_cargo_crate ripgrep
    add_to_default_cargo_crate fd-find
    add_to_default_cargo_crate tree-sitter-cli
fi

# Install the SDKs
echo "Checking for SDKs"
which_asdf_result=$(which asdf)
if begins_with "asdf () {" "$which_asdf_result"; then
    install_latest rust code-lever/asdf-rust
    install_latest nodejs asdf-vm/asdf-nodejs
    install_latest python asdf-community/asdf-python
    install_latest lua Stratus3D/asdf-lua
    install_latest ruby asdf-vm/asdf-ruby
    install_latest golang kennyp/asdf-golang
    install_latest neovim richin13/asdf-neovim
else
    echo "ASDF not sourced, run ./install/tools.sh manually"
fi

# Install NeoVIM configuration
# echo "Checking for NeoVIM configuration"
# if ! [ -d ~/.config/nvim ]; then
#     echo "Installing NeoVIM configuration"
#     git clone --depth 1 https://github.com/grmisasi/nvim-config-lua ~/.config/nvim/
#     #nvim --headless "+Lazy! sync" +qa
# fi

# [Optional] Install AWS Cli
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip -q awscliv2.zip && ./aws/install