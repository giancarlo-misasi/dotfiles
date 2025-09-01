#!/bin/bash

set -e

DOTFILES="$HOME/workspaces/dotfiles"
if command -v apt-get >/dev/null 2>&1; then
    PACKAGE_MANAGER="apt-get"
elif command -v yum >/dev/null 2>&1; then
    PACKAGE_MANAGER="yum"
else
    echo "Unsupported platform: Neither apt nor yum found."
    exit 1
fi

link_dotfiles() {
    # delete existing config or links
    rm -f $HOME/.zshrc
    rm -f $HOME/.tmux.conf
    rm -rf $HOME/.tmux
    rm -rf $HOME/.config/nvim

    # create directories that need to exist
    mkdir -p $HOME/.config/

    # create links
    ln -sf "$DOTFILES/config/zsh/zshrc" "$HOME/.zshrc"
    ln -sf "$DOTFILES/config/tmux/tmux.conf" "$HOME/.tmux.conf"
    ln -sf "$DOTFILES/config/tmux" "$HOME/.tmux"
    ln -sf "$DOTFILES/nvim" "$HOME/.config/nvim"
}

install_system() {
    echo "Installing packages using $PACKAGE_MANAGER"
    if [ "$PACKAGE_MANAGER" = "apt-get" ]; then
        # Preconfigure tzdata to avoid prompts
        export DEBIAN_FRONTEND=noninteractive
        apt-get -y update
        apt-get -y install tzdata zsh curl wget zip unzip git vim build-essential gcc g++ gdb
    elif [ "$PACKAGE_MANAGER" = "yum" ]; then
        yum -y update
        yum -y install tzdata zsh curl wget zip unzip git vim gcc gcc-c++ gdb make
    fi
}

install_ohmyzsh() {
    # switch shell to zsh
    if command -v zsh >/dev/null 2>&1; then
        echo "Switching default shell to zsh"
        chsh -s "$(which zsh)"
    fi

    # backup existing config
    mv $HOME/.zshrc $HOME/.zshrc.bak
    touch $HOME/.zshrc

    # install ohmyzsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

install_mise() {
    # install mise
    if ! command -v mise &> /dev/null
    then
        curl https://mise.run | sh
    fi

    # activate mise
    eval "$($HOME/.local/bin/mise activate zsh)"
}

mise_use() {
    local tools=("$@")
    for tool in "${tools[@]}"; do
        mise use -g -f -y "$tool"
    done
}

install_tools_and_languages() {
    # install tools
    mise_use tmux fzf ripgrep fd tree-sitter neovim lazygit

    # install languages + language tools
    mise_use lua python kotlin gradle node
}

print_help() {
    echo "Usage: $0 [function_name]"
    echo "Available functions:"
    echo "  link_dotfiles"
    echo "  install_system"
    echo "  install_ohmyzsh"
    echo "  install_mise"
    echo "  install_tools_and_languages"
    echo "If no function is specified, all steps will run."
}

if [ "$1" = "help" ] || [ "$1" = "--help" ]; then
    print_help
elif declare -f "$1" > /dev/null; then
    # Run the specified function if it exists
    echo "Running specified step: $1"
    "$1"
else
    echo "Error: Function '$1' not found."
    print_help
    exit 1
fi
