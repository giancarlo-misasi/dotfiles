## Summary
Installs neovim, neovim configuration + all dependencies and tools needed

## Quickstart
> Unix, Linux, Wsl Installation

```shell
apt-get -qq -o=Dpkg::Use-Pty=0 -y update && apt-get -qq -o=Dpkg::Use-Pty=0 -y install git
git clone https://github.com/grmisasi/nvim-config-lua ~/.config/nvim/ --quiet
cd ~/.config/nvim
chmod u+x install.sh
./install.sh
```
