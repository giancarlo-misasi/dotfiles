# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install tmux config
cp config/.tmux.config ~/

# install custom scripts
mkdir -p ~/.tmux/scripts/
cp config/tmux-commands.sh ~/.tmux/scripts/
