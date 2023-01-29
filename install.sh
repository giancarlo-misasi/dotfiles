#!/bin/bash

# Make sure prompt string is passed in
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 PROFILE_PROMPT_PREFIX" >&2
  exit 1
fi

# Set permissions for install script folder
chmod -R u+x install/

# Install required dependencies
./install/dependencies.sh

# Install and setup oh-my-zsh shell awesomizer
./install/oh-my-zsh.sh $1

# Install and setup asdf version manager
./install/asdf.sh

# Install tools
./install/tools.sh

# Change to zsh shell
exec zsh -l