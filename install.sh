#!/bin/bash

# Check that we are up to date and have basic requirements
echo "Checking for curl and wget"
apt-get -qq -y update
apt-get -qq -y install curl wget git zsh
chsh -s /bin/zsh

# Set permissions for install script folder
chmod -R u+x install/

# Install required dependencies
./install/dependencies.sh

# Install and setup oh-my-zsh shell awesomizer
./install/oh-my-zsh.sh

# Install and setup asdf version manager
./install/asdf.sh

# Install tools
./install/tools.sh

#nvim --headless "+Lazy! sync" +qa

# Change to zsh shell
exec zsh -l