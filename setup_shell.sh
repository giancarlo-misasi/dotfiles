#!/bin/bash

# set the prompt alias to use for the shell
if [ -z "$1" ]; then
  echo "Usage: setup_env.sh [SHELL_PREFIX]"
  exit 1
fi

# backup existing shell configuration
mv ~/.zshrc ~/.zshrc.bak
touch ~/.zshrc

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# setup shell configuration
cat <<EOF >> ~/.zshrc
# setup the shell prompt prefix
PROMPT="$1 %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
EOF