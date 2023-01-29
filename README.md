## Summary
Installs neovim, neovim configuration + all dependencies and tools needed

## Quickstart
> Debian Installation

```shell
apt-get -qq -y update
apt-get -qq -y install git
git clone https://github.com/grmisasi/nvim-config-lua $HOME/.config/nvim/ --quiet
cd $HOME/.config/nvim
chmod u+x install.sh
./install.sh
```

> Centos / Fedora Installation

```shell
yum -q -y update
yum -q -y install git
git clone https://github.com/grmisasi/nvim-config-lua $HOME/.config/nvim/ --quiet
cd $HOME/.config/nvim
chmod u+x install.sh
./install.sh
```
