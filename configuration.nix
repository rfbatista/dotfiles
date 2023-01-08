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
  home-manager = fetchTarball "https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz";
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
    (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; } )     (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];
  # if you also want support for flakes
  imports = [ "${home-manager}/nixos" 
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

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


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
      libvterm
      sumneko-lua-language-server
      flutter
      gnumake
      gnupatch
      lua
      neovim
      fd
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
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    passwordFile = "/etc/passwordFile-rfbatista";
    shell = pkgs.zsh;
  };

  # Disable password-based login for root.
  users.users.root.hashedPassword = "!";

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


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # Configure swap file. Sizes are in megabytes. Default swap is
  # max(1GB, sqrt(RAM)) = 1024. If you want to use hibernation with
  # this device, then it's recommended that you use
  # RAM + max(1GB, sqrt(RAM)) = 16777.000.
  swapDevices = [ { device = "/swapfile"; size = 1024; } ];
}
