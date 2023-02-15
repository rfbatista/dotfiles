{ config, pkgs, ... }:
{ 

   systemd.timers."wallpaper" = {
      wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "1m";
          OnUnitActiveSec = "2m";
          Unit = "wallpaper.service";
        };
    };

    systemd.services."wallpaper" = {
      script = ''
        set -eu
        export DISPLAY=:0
        ${pkgs.feh}/bin/feh --bg-fill --randomize /home/rfbatista/Pictures/wallpaper/*
      '';
      serviceConfig = {
        Type = "oneshot";
        User= "rfbatista";
      };
    };
 
}

