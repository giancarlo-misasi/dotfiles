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

    "Quit"
)

actions=(
    "tmux command-prompt -p \"session name: \" \"run-shell 'tmux new-session -d -s \"%1\"; tmux switch-client -t \"%1\"'\""
    "tmux command-prompt -I \"#S\" \"rename-session -- '%%'\""
    "tmux switch-client -t \$(tmux list-sessions -F '#{session_name}' | fzf --tmux)"
    "tmux kill-session"

    "tmux new-window"
    "tmux command-prompt -I \"#W\" \"rename-window -- '%%'\""
    "tmux kill-window"

    "tmux resize-pane -Z"
    "tmux split-window -h -c \"#{pane_current_path}\""
    "tmux split-window -v -c \"#{pane_current_path}\""
    "tmux kill-pane"

    "tmux detach-client -P"
)

# prompt with fzf and then execute the selected command
selected_command=$(printf "%s\n" "${commands[@]}" | fzf --tmux --prompt="Pick an action: ")
if [ -n "$selected_command" ]; then
    for i in "${!commands[@]}"; do
        if [ "${commands[$i]}" == "$selected_command" ]; then
            index=$i
            break
        fi
    done
    eval "${actions[$index]}"
fi

