## Summary
Installs neovim, neovim configuration + all dependencies and tools needed

## Quickstart

```shell
mkdir -p ~/workspaces/
cd workspaces/
git clone https://github.com/giancarlo-misasi/dotfiles
cd dotfiles
./install.sh
```

## Clipboard providers
### Windows
```shell
winget install win32yank
```

### SSH
Using lemonade (osc52 doesnt work with windows terminal due to paste)
```shell
# install on host and server
go install github.com/lemonade-command/lemonade@latest

# setup remote forwarding rules in ssh config
RemoteForward 2489 localhost:2489 # for lemonade

# start the server on the host machine
lemonade server -allow 127.0.0.1 &

# done - neovim will auto-detect lemonade as a provider on ssh
```
Alternatively, create a .zshrc.d/clipboard.lua file
```
cmd="/home/$USER/.local/share/mise/installs/go/1.23.3/bin/lemonade"
if command -v "$cmd" >/dev/null 2>&1; then
  if ! pgrep -x "lemonade" >/dev/null 2>&1; then
    nohup $cmd server -allow 127.0.0.1 &
  fi
fi
```
