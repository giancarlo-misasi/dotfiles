#!/bin/bash

cat <<EOF > "Dockerfile"
FROM ubuntu:latest

# install git to clone the repo
RUN apt-get update
RUN apt-get install -y git

# clone the dotfile repo
RUN git clone https://github.com/giancarlo-misasi/dotfiles.git /dotfiles

# run the scripts
WORKDIR /dotfiles
RUN ./install.sh

CMD ["/bin/zsh"]
EOF

# build and run a container to test the setup
docker build -t test-my-environment-setup .
docker run --rm -it test-my-environment-setup
