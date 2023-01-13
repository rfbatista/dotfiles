################################################################################
# █▄░█ █ ▀▄▀ █▀█ █▀ ▄▄ █░█ █▀█
# █░▀█ █ █░█ █▄█ ▄█ ░░ █▄█ █▀▀
#
# 🚀 This NixOS installation brought to you by nixos-up! 🚀
# Please consider supporting the project (https://github.com/samuela/nixos-up)
# and the NixOS Foundation (https://opencollective.com/nixos)!
################################################################################

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ...}:

let
  # home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz";
    sha256 = "0000000000000000000000000000000000000000000000000000;
  };
in
{
  # Your home-manager configuration! Check out https://rycee.gitlab.io/home-manager/ for all possible options.
  home-manager.users.rfbatista = { pkgs, ... }: {
    home.packages = with pkgs; [ hello ];
    programs.starship.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };

  nixpkgs.overlays = [
    (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = false; }; } )
  ];

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];
  # if you also want support for flakes
  imports = [
 # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./zsh.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "renan-notebook"; # Define your hostname.

  networking.wireless.userControlled.enable = true;

  # Pick only one of the below networking options.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  # networking.networkmanager.enable = true;


  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };
  
  environment = {
    systemPackages = with pkgs; [
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
    ];
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  virtualisation.docker.enable = true;



	fonts.fonts = with pkgs; [
	  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
	];

  # Enable the X11 windowing system.
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


  services.teamviewer.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: rec {
    };
  };
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  users.mutableUsers = false;
  users.users.rfbatista = {
    isNormalUser = true;
    extraGroups = [ wheel networkmanager docker ];
    passwordFile = /etc/passwordFile-rfbatista;
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  security.sudo.enable = true;

}
