#!/bin/bash

# Set timezone
echo "Checking for timezone"
ln -snf /usr/share/zoneinfo/America/Vancouver /etc/localtime

# Check which system we are on
source /etc/os-release
if [[ "$ID_LIKE" == *"debian"* ]]; then

    echo "Checking for dependencies - debian"
    apt-get -qq -y update
    apt-get -qq -y install \
    build-essential \
    autoconf \
    bison \
    cmake \
    curl \
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
    locales \
    patch \
    sudo \
    tk-dev \
    unzip \
    uuid-dev \
    wget \
    xz-utils \
    zip \
    zsh \
    zlib1g-dev

    # Generate locale
    locale-gen en_US.UTF-8

elif [[ "$ID_LIKE" == *"fedora"* ]]; then

    echo "Checking for dependencies - fedora"
    yum -q -y update
    yum -q -y groupinstall "Development Tools"
    yum -q -y install \
    bzip2 \
    bzip2-devel  \
    cmake \
    curl \
    gdbm-devel \
    libffi-devel \
    libyaml-devel \
    ncurses-devel \
    openssl-devel \
    patch \
    readline-devel \
    sqlite \
    sqlite-devel \
    sudo \
    tk-devel \
    unzip \
    wget \
    xz-devel \
    zip \
    zsh \
    zlib-devel

    # Generate locale
    localedef -c -f UTF-8 -i en_US en_US.UTF-8

fi