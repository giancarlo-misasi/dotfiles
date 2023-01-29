#!/bin/bash

# Install ASDF
echo "Checking for ASDF"
if ! [ -d ~/.asdf ]; then
    echo "Installing ASDF"
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1 -c advice.detachedHead=false --quiet
fi