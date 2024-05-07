git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf $HOME/dotfiles/tmux $XDG_CONFIG_HOME
tmux source $XDG_CONFIG_HOME/tmux/tmux.conf 
