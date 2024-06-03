#!/bin/bash

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sed -i 's/plugins=(git)/plugins=(git vscode)/' ~/.zshrc

# Install brew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Generate custom profile script
cat <<'EOF' > ~/.zshrc-custom
# Path exports
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

# Vim aliases
alias vim="nvim"
alias vi="nvim"
export EDITOR=nvim

# Brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Setup the prefix that will appear in the shell prompt
PROFILE_PROMPT_PREFIX=legian-wsl
PROMPT="$PROFILE_PROMPT_PREFIX %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

EOF

# Register custom profile script
(echo; echo '# Register custom profile script'; echo '. ~/.zshrc-custom') >> ~/.zshrc
. ~/.zshrc-custom
