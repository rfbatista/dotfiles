# NVIM

# Font install
# https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack/Bold#quick-installation

# Change vim directory
mkdir ~/.config
mkdir ~/.config/nvim
touch ~/.config/nvim/init.lua
ln -sf ~/dotfiles/init.lua ~/.config/nvim/init.lua 
ln -sf ~/dotfiles/lua ~/.config/nvim/lua 
ln -sf ~/dotfiles/i3/config ~/.config/i3/config

#############
# Tmux
#############

# Tmux plugin manager
# https://github.com/tmux-plugins/tpm
