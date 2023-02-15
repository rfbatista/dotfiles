{ config, pkgs, ... }:
{
  users.extraGroups.networkmanager.members = [ "root" ];
  users.extraUsers.rfbatista.extraGroups = [ "wheel" ];
  networking = {
    hostName = "rf-notebook"; # Define your hostname.
    firewall.enable = false;
    wireless.userControlled.enable = true;
    wireless.enable = true;
  };

  networking.wireless.networks.Beatriz_5G.pskRaw = "5528554430450893c988c5da7019ac90397f41ca28421b9c3a65c71ce4f15dde";

  networking.extraHosts = '' '';
  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  systemd.services.NetworkManager-wait-online.enable = true;
}
