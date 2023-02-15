{ config, pkgs, ... }:
{
  config.xdg.mime = {
      enable = true;
      associations.added = {
        "application/pdf" = ["org.gnome.Evince.desktop"];
      };
      defaultApplications = {
        "application/pdf" = ["org.gnome.Evince.desktop"];
      };
  };
} 
