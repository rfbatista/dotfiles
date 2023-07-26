{ config, pkgs, ... }:
{
  config.xdg.mime = {
      enable = true;
      addedAssociations = {
        "application/pdf" = ["org.gnome.Evince.desktop"];
        "x-scheme-handler/http" = ["google-chrome.desktop"];
        "x-scheme-handler/https" = ["google-chrome.desktop"];
        "text/html" = ["google-chrome.desktop"];
      };
      defaultApplications = {
        "application/pdf" = ["org.gnome.Evince.desktop"];
        "text/html" = ["google-chrome.desktop"];
        "x-scheme-handler/about" = ["google-chrome.desktop"];
        "x-scheme-handler/http" = ["google-chrome.desktop"];
        "x-scheme-handler/https" = ["google-chrome.desktop"];
        "x-scheme-handler/unknown" = ["google-chrome.desktop"];
        "application/vnd.mozilla.xul+xml" = ["google-chrome.desktop"];
        "application/xhtml+xml" = ["google-chrome.desktop"];
        "text/mml" = ["google-chrome.desktop"];
        "text/xml" = ["google-chrome.desktop"];
      };
  };
} 
