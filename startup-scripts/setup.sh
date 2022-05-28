#/bin/sh!

chmod u+x $HOME/dotfiles/startup-scripts/common.service
ln -sf $HOME/dotfiles/startup-scripts/common.service /etc/systemd/system/common.service
sudo systemctl common.service
sudo systemctl enable common.service

