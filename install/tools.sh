#!/bin/zsh

install_latest() {
    asdf plugin add $1 "https://github.com/$2.git"
    asdf install $1 latest
    asdf global $1 latest
}

# Make sure profile is loaded
source $HOME/.zshrc

# Install the SDKs
echo "Checking for SDKs"
install_latest rust asdf-community/asdf-rust
cargo install ripgrep # for neovim searches
cargo install fd-find # for neovim searches
cargo install tree-sitter-cli # for neovim tree-sitter plugin
install_latest python asdf-community/asdf-python
pip install compiledb # for generating compilation database
pip install boto3 # for aws sdk access
install_latest ruby asdf-vm/asdf-ruby
install_latest nodejs asdf-vm/asdf-nodejs
install_latest lua Stratus3D/asdf-lua
install_latest golang kennyp/asdf-golang
install_latest neovim richin13/asdf-neovim

# Attempt to update neovim plugins
nvim --headless +"Lazy! sync" +"TSUpdate"  +"qa"

# Install AWS Cli
if ! [ -f /usr/local/bin/aws ]; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip -q awscliv2.zip \
    && ./aws/install
fi