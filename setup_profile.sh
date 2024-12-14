echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
echo 'git config --global core.editor "nvim"' >> ~/.zshrc
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  if ! tmux has-session 2>/dev/null; then
    tmux new-session -s default
  else
    tmux a
  fi
fi
