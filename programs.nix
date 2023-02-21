{ config, pkgs, ... }:
{
  
      services.teamviewer.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
      transmission
      transmission-gtk
      vlc
      spotify
      xorg.xkbcomp
      xorg.xev
# programmings
      jetbrains.idea-ultimate
      dbeaver
      beekeeper-studio
      postgresql
      vscode
      ngrok
# rust
  openssl
  cargo-tarpaulin
  lld
  rust-analyzer
  cargo
  rustup
# lua
      stylua
# python 
      pipenv

# utilities
      lsof
      evince 
      slack

# wallpapers
      feh

      curl
      python3
      python310Packages.pip
      python310Packages.pipx
      wget
      bash
      dmenu
      firefox
      atom
      alacritty
      git
      starship
      polybar
      gparted
      gnome3.nautilus
      picom
      oh-my-zsh
      gcc
      dart
      tree-sitter
      graphviz
      htop
      asdf
      sumneko-lua-language-server
      flutter
      gnumake
      gnupatch
      lua
      xclip
      cmake
      pkg-config
      glibc 
      clang
      android-studio
      readline
      luarocks
      python3
      teams
      jetbrains.datagrip
      adoptopenjdk-openj9-bin-16
      direnv
      unzip
      teamviewer
      gh
      shotwell
      starship
      ripgrep
      postman
      wpa_supplicant_gui
      networkmanager
      shutter
      killall
      docker-compose
      gnumake
      feh
      calibre
      gopls
      go_1_18
      lazygit
      dpkg
      nodejs
      tmux
      rofi
      unzip
      gnome.gnome-control-center
      wget
      zsh


      neovim-nightly
      gettext
      ninja
      libvterm-neovim
      fd
      lazydocker

  ];

}
