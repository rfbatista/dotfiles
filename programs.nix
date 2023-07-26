{ config, pkgs, ... }:
{
  
      services.teamviewer.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget

  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
      obsidian
      obs-studio
      transmission
      transmission-gtk
      ffmpeg
      vlc
      spotify
      xorg.xkbcomp
      xorg.xev
      pcmanfm
      tdesktop
      yarn
      chromium
#java
      openjdk17

# programmings
      jq
      google-cloud-sdk
      spring-boot-cli
      terraform
      awscli2
      infracost
      nix-index
      bash
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
      python3
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
      android-tools
      readline
      luarocks
      teams
      jetbrains.datagrip
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
      go_1_19
      lazygit
      dpkg
      nodejs
      tmux
      rofi
      unzip
      gnome.gnome-control-center
      wget
      zsh


      google-chrome
      neovim-nightly
      gettext
      ninja
      libvterm-neovim
      fd
      lazydocker

  ];

}
