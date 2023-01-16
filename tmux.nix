{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
   plugins = with pkgs.tmuxPlugins; [
      power-theme
      cpu
    ];
    extraConfig = '' # used for less common options, intelligently combines if defined in multiple places.
      unbind-key C-b

      set-option -g prefix A-p

      bind-key A-p send-prefix

      bind \ split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };
}
