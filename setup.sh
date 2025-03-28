ln -s $HOME/dotfiles/.profile ~/.profile
sudo pacman -S unzip
sudo pacman -S rofi
sudo pacman -S feh 
sudo pacman -S zellij

pacman -S curl git


echo 'current shell'
echo $SHELL
echo '\n'
echo 'all installed shells'
chsh -l
chsh -s /usr/bin/zsh

echo 'installing asdf'

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1


echo 'installing audio components'
pacman -S pulseaudio pulseaudio-alsa pulseaudio-bluetooth pavucontrol


echo 'you need to restart now'

# ln -s $HOME/dotfiles/.profile ~/.profile
