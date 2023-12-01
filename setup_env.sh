#!/bin/bash

# Setup the prefix that will appear in the shell prompt
PROFILE_PROMPT_PREFIX=legian-wsl
PROMPT="$PROFILE_PROMPT_PREFIX %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sed -i 's/plugins=(git)/plugins=(git asdf vscode)/' ~/.zshrc

# Install brew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install tools using brew
brew install neovim fzf ripgrep fd compiledb asdf

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

# Generate custom profile script
cat <<'EOF' > ~/.zshrc-custom
# Path exports
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

# Vim aliases
alias vim="nvim"
alias vi="nvim"
export EDITOR=nvim

# Fixes
alias pip="python -m pip"

# Brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ASDF
unset ASDF_DIR
. /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh
EOF

# Register custom profile script
(echo; echo '# Register custom profile script'; echo '. ~/.zshrc-custom') >> ~/.zshrc
. ~/.zshrc-custom