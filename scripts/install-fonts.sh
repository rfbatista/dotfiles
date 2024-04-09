#!/bin/bash

# Dirs
FDIR="$HOME/.local/share/fonts"

# Install Fonts
install_fonts() {
	echo -e "\n[*] Installing fonts..."
	if [ -d "$FDIR" ]; then
		cp -rf $HOME/fonts/* "$FDIR"
	else
		mkdir -p "$FDIR"
		cp -rf $HOME/fonts/* "$FDIR"
	fi
    echo -e "\nFonts installed."
  fc-cache -f -v
}

install_fonts
