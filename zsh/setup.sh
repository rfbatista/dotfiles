ln -s $HOME/dotfiles/zsh/.zshrc ~/.zshrc
chsh -s $(which zsh)
echo "exec zsh" > "~/.bashrc"
