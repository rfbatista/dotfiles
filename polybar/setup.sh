#!/bin/bash
chmod +x $HOME/dotfiles/polybar/launch.sh
ln -s ~/dotfiles/polybar ~/.config/polybar
chomod +x $HOME/dotfiles/polybar/keyboard-script.sh
git clone --depth 1 https://github.com/Murzchnvok/polybar-collection
