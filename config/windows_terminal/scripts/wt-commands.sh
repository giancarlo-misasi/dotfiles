#!/bin/bash

commands=(
    "Split right"
    "Split down"
    "Close split"
)

actions=(
    "wt.exe split-pane"
    "wt.exe split-pane -H"
    "wt.exe focus-pane -C"
)

# prompt with fzf and then execute the selected command
selected_command=$(printf "%s\n" "${commands[@]}" | fzf --prompt="Pick an action: ")
if [ -n "$selected_command" ]; then
    for i in "${!commands[@]}"; do
        if [ "${commands[$i]}" == "$selected_command" ]; then
            index=$i
            break
        fi
    done
    eval "${actions[$index]}"
fi
