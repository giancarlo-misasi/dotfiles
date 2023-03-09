#!/bin/zsh

# Make sure profile is loaded
source $HOME/.zshrc

# Install the SDKs
echo "Checking for SDKs"
asdf_install_latest rust code-lever/asdf-rust # asdf-community/asdf-rust - codelever uses rustup which is better
cargo install ripgrep # for neovim searches
cargo install fd-find # for neovim searches
cargo install tree-sitter-cli # for neovim tree-sitter plugin
asdf_install_latest python asdf-community/asdf-python
pip install compiledb # for generating compilation database
pip install boto3 # for aws sdk access
asdf_install_latest ruby asdf-vm/asdf-ruby
asdf_install_latest nodejs asdf-vm/asdf-nodejs
npm install -g @devcontainers/cli # for devcontainer api
asdf_install_latest lua Stratus3D/asdf-lua
asdf_install_latest golang kennyp/asdf-golang

# Install AWS Cli
if ! [ -f /usr/local/bin/aws ]; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip -q awscliv2.zip \
    && ./aws/install
fi
