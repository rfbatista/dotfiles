#!/bin/bash

# Dirs
FDIR="$HOME/.local/share/fonts"

# Install Fonts
install_fonts() {
	echo -e "\n[*] Installing fonts..."
	if [ -d "$FDIR" ]; then
		cp -rf ~/dotfiles/fonts/* "$FDIR"
	else
		mkdir -p "$FDIR"
		cp -rf ~/dotfiles/fonts/* "$FDIR"
	fi
    echo -e "\nFonts installed."
  fc-cache -f -v
}

install_fonts
