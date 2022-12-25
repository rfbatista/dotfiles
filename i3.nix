{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.default = "i3"
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      # disable generation of default config
      configFile = ./i3/config;
      extraConfig = lib.strings.fileContents ./i3/config;
    };
  };
}
