#!/bin/bash

# Set timezone
echo "Checking for timezone"
ln -snf /usr/share/zoneinfo/America/Vancouver /etc/localtime

# Install dependencies
echo "Checking for dependencies"
apt-get -qq -o=Dpkg::Use-Pty=0 -y install \
autoconf \
bear \
bison \
build-essential \
bzip2 \
cmake \
coreutils \
git \
libbz2-dev \
libdb-dev \
libffi-dev \
libgdbm-dev \
libgmp-dev \
liblzma-dev \
libncursesw5-dev \
libreadline-dev \
libsqlite3-dev \
libssl-dev \
libxml2-dev \
libyaml-dev \
make \
patch \
sudo \
tk-dev \
unzip \
uuid-dev \
xz-utils \
zip \
zlib1g-dev