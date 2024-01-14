## Summary
Installs neovim, neovim configuration + all dependencies and tools needed

## Quickstart
> Step 1 - Environment setup

```shell
apt-get -y update
apt-get -y install zsh curl wget zip unzip git vim
apt-get -y install build-essential gcc g++ libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev \
    xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

```

> Step 2 - Tooling setup

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/giancarlo-misasi/nvim-config-lua/main/setup_env.sh)"
```

> Step 2 - Neovim setup

```shell
git clone https://github.com/grmisasi/nvim-config-lua
./nvim-config-lua/setup_nvim.sh
```
