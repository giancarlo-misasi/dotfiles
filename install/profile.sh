#!/bin/bash

write_to_profile() {
    echo $1 >> ~/shell_customizations
}

# Setup profile
echo "Checking for shell customizations"
if ! [ -d ~/shell_customizations ]; then
    echo "Installing shell customizations"
    touch ~/shell_customizations

    # Add aliases
    write_to_profile "# Setup aliases"
    write_to_profile "alias vim='nvim'"
    write_to_profile "alias vi='nvim'"

    # Add exports
    write_to_profile "# Setup exports"
    write_to_profile "export EDITOR=nvim"

    # Change prompt to make it easier to know where I am
    write_to_profile "# Setup shell prompt"
    write_to_profile "export HOST_PROMPT='grm-wsl'"
    write_to_profile "export PROMPT='%(!.%{%F{yellow}%}.)$HOST_PROMPT% ${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'"

    # Add go proxy fix
    write_to_profile "# Go proxy fix"
    write_to_profile "export GOPROXY=direct"

    # Register .zshrc customizations
    echo "source ~/shell_customizations" >> ~/.zshrc
fi