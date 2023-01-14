# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { };
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./programs.nix
    ];

  nix = {
    package = pkgs.nixUnstable; # or versioned attributes like nix_2_4
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  networking = {
    hostName = "rf-notebook"; # Define your hostname.
    firewall.enable = false;
    wireless.userControlled.enable = true;
    wireless.enable = true;
  };

  time.timeZone = "America/Sao_Paulo";
  users.users.rfbatista = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    passwordFile = "/etc/passwordFile-rfbatista";
    shell = pkgs.zsh;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.variables = {
    SYS_THEME = "dark";
    VI_CONFIG = "~/.config/nvim/init.vim";
  };

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

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  services.xserver.libinput.enable = true;

  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraModules = [];
    package = pkgs.pulseaudioFull;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.extraGroups.networkmanager.members = [ "root" ];

  # services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.allowUnfree = true;


  virtualisation.docker.enable = true;

  fonts.fonts = with pkgs; [
	  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  networking.extraHosts = '' '';

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
