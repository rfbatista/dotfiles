wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
sudo mv JetBrainsMono /usr/share/fonts/
fc-cache -fv
fc-list | grep "JetBrainsMono"


wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Agave.zip
unzip Agave.zip -d Agave
sudo mv Agave /usr/share/fonts/
fc-cache -fv


