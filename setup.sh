# NVIM
# sudo add-apt-repository ppa:neovim-ppa/unstable
# sudo apt update
# sudo apt install neovim

# Font install
# https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack/Bold#quick-installation

# Change vim directory
export VIMINIT="source ~/dotfiles/.vimrc"
# ln -sf ~/dotfiles/.vimrc ~/.vimrc 
# ln -sf ~/dotfiles/init.vim ~/.config/nvim/init.vim 
ln -sf ~/dotfiles/init.lua ~/.config/nvim/init.lua 
ln -sf ~/dotfiles/lua ~/.config/nvim/lua 

# Vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Share config between nvim and vim
# mkdir ~/.config/nvim
# touch ~/.config/nvim/init.vim
# cat "set runtimepath^=/.vim runtimepath+=~/.vim/after
# let &packpath = &runtimepath
# source ~/dotfiles/.vimrc" > ~/.config/nvim/init.vim

# Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


# Lunar Vim
# bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
