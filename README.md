## Summary
Installs neovim, neovim configuration + all dependencies and tools needed

## Quickstart
> Debian Installation

```shell
apt-get -y update
apt-get -y install git
git clone https://github.com/grmisasi/nvim-config-lua $HOME/.config/nvim/
cd $HOME/.config/nvim
chmod -R u+x install/
sudo ./install/dependencies.sh
./install/oh-my-zsh.sh MACHINE_PROMPT
./install/asdf
./install/tools.sh
```

> Fedora Installation

```shell
yum -y update
yum -y install git
git clone https://github.com/grmisasi/nvim-config-lua $HOME/.config/nvim/
cd $HOME/.config/nvim
chmod -R u+x install/
sudo ./install/dependencies.sh
./install/oh-my-zsh.sh MACHINE_PROMPT
./install/asdf
./install/tools.sh
```
