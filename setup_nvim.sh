# backup current nvim config
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# install the nvim dotfiles
mkdir -p ~/.config/nvim/ && cp -ru nvim/* ~/.config/nvim/