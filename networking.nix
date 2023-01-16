{ config, pkgs, ... }:
{
  users.extraGroups.networkmanager.members = [ "root" ];
  networking = {
    hostName = "rf-notebook"; # Define your hostname.
    firewall.enable = false;
    wireless.userControlled.enable = true;
    wireless.enable = true;
  };
  networking.extraHosts = '' '';
  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  systemd.services.NetworkManager-wait-online.enable = true;
}
