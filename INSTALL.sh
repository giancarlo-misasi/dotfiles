#!/bin/zsh

# Clean any previous installs or settings
echo 'Cleaning previous installs'
rm -rf ~/.config/nvim/plugin
rm -rf ~/.local/share/nvim/site/pack

# Copy additional required files from Github
echo 'Copying files from Github'
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Run headless install of packer
echo 'Running headless install of packer'
nvim --headless -c 'au User PackerComplete quitall' -c 'PackerSync'
