echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
echo 'git config --global core.editor "nvim"' >> ~/.zshrc
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux a # attach to the last session
fi
