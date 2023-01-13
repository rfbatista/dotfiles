{ config, pkgs, ... }:

{

  programs.home-manager.enable = true;
  home.username = "rfbatista";
  home.homeDirectory = "/home/rfbatista";

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: rec {
    };
  };

  services.picom.enable = true;

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    viAlias = true;
    withPython3 = true;
    extraConfig = ''luafile /home/rfbatista/dotfiles/nvim/init.lua'';

    extraPackages = with pkgs; [
      tree-sitter
      pkgs.rnix-lsp
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.vim-language-server
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.intelephense
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.yaml-language-server
      sumneko-lua-language-server
      texlab
      rust-analyzer
      deno
      stylua
      nodePackages.prettier
      perl534Packages.PerlTidy
      perl534Packages.PerlCritic
      perlPackages.PLS
      sqlite

    ];
  };

  # Pick only one of the below networking options.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  # networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  security.sudo.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  users.mutableUsers = false;
  users.users.rfbatista = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    passwordFile = "/etc/passwordFile-rfbatista";
    shell = pkgs.zsh;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;


 services.xserver = {
        enable = true;
	wacom.enable = true;
	layout = "br";
	xkbVariant = "nodeadkeys";
	xkbModel = "latitude";
        desktopManager = {
                xterm.enable = false;
        };
        displayManager = {
                defaultSession = "none+i3";
        };
        windowManager.i3 = {
                enable = true;
                extraPackages = with pkgs; [
                        dmenu
                        i3status
                        i3lock
                        i3blocks
                ];
		package = pkgs.i3-gaps;
		configFile = "/etc/nixos/i3/config";
        };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  virtualisation.docker.enable = true;

	fonts.fonts = with pkgs; [
	  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
	];

  programs.rofi = {
    enable = true;
    font = "FiraCode 20";
    theme = ./programs/rofi/themes/slate.rasi;
  };

    # tcpdump
    # firefox
    # plocate
    # termite
    # alacritty
    # rustup
    # polybar
    # pkg-config
    # zoxide
    # starship
    # exa
    # neofetch
    # volumeicon
    # sxhkd
    # haskellPackages.greenclip
    # feh
    # rofi
    # skim
    # pavucontrol
    # ponymix
    # unzip
    # fzf
    # fzy
    # arandr
    # autorandr
    # bat
    # ripgrep
    # lua
    # lua53Packages.luarocks
    # python3
    # fd
    # sad
    # gh
    # python3
    # nodejs
    # flameshot
    # rofi-power-menu
    # webcamoid
    # nixpkgs-fmt
    # slack
    # docker-compose
    # libnotify
    # rofimoji
    # sysz
    # tldr
    # nix-prefetch-github
    # glow
    # element-desktop
    # mitmproxy
    # xfce.xfce4-notifyd
    # sumneko-lua-language-server
    # kazam
    # mpv
    # yt-dlp
    # pfetch
    # discord
    # python39Packages.pynvim
    # tridactyl-native
    # jq
    # mesa.drivers
    # signal-desktop
    # yarn
    # update-systemd-resolved
    # htop
    # mongodb
    # mongodb-tools
    # nodePackages.speed-test
    # nodePackages.pnpm
    # fzf
    # chromium
    # brave
    # hugo
    # cht-sh
    # keepass
    # qbittorrent

  home.packages = with pkgs;  [
    curl
    python3
    python310Packages.pip
    python310Packages.pipx
    wget
    bash
    dmenu
    firefox
    alacritty
    git
    starship
    polybar
    gparted
    gnome3.nautilus
    picom
    oh-my-zsh
    gcc
    tree-sitter
    graphviz
    htop
    asdf
    sumneko-lua-language-server
    flutter
    gnumake
    gnupatch
    lua
    neovim
    xclip
    cmake
    pkg-config
    clang
    glibc 
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
    lazygit
    dpkg
    nodejs
    tmux
    rofi
    unzip
    gnome.gnome-control-center
    wget
    zsh

    # chromium
    # leftwm
    # chromium
    # dunst
    # update-systemd-resolved
    # openvpn
    # home-manager
    # fish
    # vim
    # cargo
    # sumneko-lua-language-server
  ];

  programs.java.enable = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

}
