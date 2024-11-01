#!/bin/bash

cat <<EOF > "Dockerfile"
FROM ubuntu:latest

# install git to clone the repo
RUN apt-get update
RUN apt-get install -y git

# clone the dotfile repo
RUN git clone --branch mise-migration https://github.com/giancarlo-misasi/dotfiles.git

# run the scripts
RUN cd dotfiles
RUN ./setup_env.sh
RUN ./setup_shell.sh
RUN ./setup_tools.sh
RUN ./setup_nvim.sh

CMD ["/bin/bash"]
EOF

# build and run a container to test the setup
docker build -t test-my-environment-setup .
docker run --rm -it test-my-environment-setup
