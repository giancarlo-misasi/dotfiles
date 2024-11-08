# backup current nvim config
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
[ -d ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.bak

# install the nvim dotfiles
mkdir -p ~/.config/nvim/ && cp -ru nvim/* ~/.config/nvim/
