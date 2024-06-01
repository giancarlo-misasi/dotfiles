#!/bin/bash

brew update
brew upgrade

# Cleanup previous installs
rm -rf ~/.asdf

# Install languages with asdf
unset ASDF_DIR
. /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh
asdf_install_latest() {
    asdf plugin add $1 "https://github.com/$2/asdf-$1.git" && asdf install $1 latest && asdf global $1 latest
}
asdf_install_latest rust code-lever
asdf_install_latest golang asdf-community
asdf_install_latest lua Stratus3D
asdf_install_latest ruby asdf-vm
asdf_install_latest python asdf-community

# Install tools with cargo
cargo install tree-sitter-cli
