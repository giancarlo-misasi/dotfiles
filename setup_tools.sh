#!/bin/bash

# install mise for language and tool management
curl https://mise.run | sh
mise_use() {
    local tools=("$@")
    for tool in "${tools[@]}"; do
        mise use -g -f -y "$tool"
    done
}

# activate mise and make it always activate
eval "$(~/.local/bin/mise activate zsh)"

# install tools
mise_use fzf ripgrep fd tree-sitter neovim

# install languages
mise_use lua rust go python java gradle node

# install additional language tools
pip install hatch debugpy # python debugging
go install github.com/go-delve/delve/cmd/dlv@latest # go debugging
