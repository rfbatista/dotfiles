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
  networking.wireless.networks.Sala.pskRaw = "0938625f5710fd4300862f724ca579061e50f3eff5eb2b14f176ae50616dea35";
  networking.wireless.networks.BrasilNET_TEREZA.pskRaw = "0eea076b4661dbe27112e03df14d63198fbd4a4409375b5a4839de67043d2442";

  networking.extraHosts = '' '';
  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  systemd.services.NetworkManager-wait-online.enable = true;
}
