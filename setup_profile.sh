echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
echo 'git config --global core.editor "nvim"' >> ~/.zshrc
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  if ! tmux has-session 2>/dev/null; then
    tmux new-session -s default
  else
    TMUX_SESSION=$(tmux ls | cut -d: -f1 | fzf --prompt="Pick a session: " --print-query | tail -n1)
    tmux new-session -A -s "$TMUX_SESSION"
  fi
fi
