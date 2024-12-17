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

install_required_system_packages() {
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
    mise_use tmux fzf ripgrep fd tree-sitter neovim

    # install languages
    mise_use lua rust go python java gradle node

    # install additional language tools
    pip install hatch debugpy # python debugging
    go install github.com/go-delve/delve/cmd/dlv@latest # go debugging
}

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

install_required_system_packages
install_ohmyzsh
install_mise
install_tools_and_languages
link_dotfiles
