#!/bin/bash

commands=(
    "New session"
    "Rename session"
    "Load session"
    "Terminate session"

    "New window"
    "Rename window"
    "Close window"

    "Toggle zoom"
    "Split right"
    "Split down"
    "Close split"
    "Toggle mark"
    "Swap marked pane"

    "Install plugins"
    "Reload config"

    "Quit"
)

actions=(
    "tmux command-prompt -p \"session name: \" \"run-shell 'tmux new-session -d -s \"%1\"; tmux switch-client -t \"%1\"'\""
    "tmux command-prompt -I \"#S\" \"rename-session -- '%%'\""
    "tmux switch-client -t \$(tmux list-sessions -F '#{session_name}' | fzf --tmux)"
    "tmux kill-session -t \$(tmux list-sessions -F '#{session_name}' | fzf --tmux)"

    "tmux new-window"
    "tmux command-prompt -I \"#W\" \"rename-window -- '%%'\""
    "tmux kill-window"

    "tmux resize-pane -Z"
    "tmux split-window -h -c \"#{pane_current_path}\""
    "tmux split-window -v -c \"#{pane_current_path}\""
    "tmux kill-pane"
    "tmux select-pane -m"
    "tmux swap-pane"

    "tmux run-shell $HOME/.tmux/plugins/tpm/bindings/install_plugins"
    "tmux source-file $HOME/.tmux.conf"

    "tmux detach-client"
)

# prompt (or take the passed command)
if [ "$#" -eq 1 ]; then
    selected_command="$1"
else
    selected_command=$(printf "%s\n" "${commands[@]}" | fzf --tmux --prompt="Pick an action: ")
fi

# execute the selected command
if [ -n "$selected_command" ]; then
    for i in "${!commands[@]}"; do
        if [ "${commands[$i]}" == "$selected_command" ]; then
            index=$i
            break
        fi
    done
    eval "${actions[$index]}"
fi

