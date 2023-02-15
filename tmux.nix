{ config, pkgs, ... }:
{

# programs.tmux.plugins = with pkgs.tmuxPlugins; [
#     resurrect
#     tilish
#     dracula
# ];


  programs.tmux = {
    enable = true;
    shortcut = "t";
    clock24 = true;
    baseIndex = 1;
    newSession = true;
     plugins = with pkgs.tmuxPlugins; [
      power-theme
      cpu
      resurrect
      onedark-theme
    ];
    extraConfig = '' # used for less common options, intelligently combines if defined in multiple places.

# bind \ split-window -h -c "#{pane_current_path}"
# bind - split-window -v -c "#{pane_current_path}"
# bind c new-window -c "#{pane_current_path}"

# reload config file (change file location to your the tmux.conf you want to use)
bind r source-file ~/.tmux.conf

set -g mouse on

# don't rename windows automatically
set-option -g allow-rename off

# remap prefix from 'C-b' to 'C-s'
      unbind C-b
      set-option -g prefix C-s
      bind-key C-a send-prefix

# split panes using | and -
      bind ] split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

# switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

# # Start windows and panes at 1, not 0
#       set -g base-index 1
#       setw -g pane-base-index 1

# THEME
  # set -g status-bg black
  # set -g status-fg white
  # set -g status-interval 60
  # set -g status-left-length 30
  # set -g status-left '#[fg=green](#S) #(whoami)'
  # set -g status-right '#[fg=yellow]#(cut -d " " -f 1-3 /proc/loadavg)#[default] #[fg=white]%H:%M#[default]'

# PLUGINS

run-shell ${pkgs.tmuxPlugins.onedark-theme}/share/tmux-plugins/onedark-theme/onedark-theme.tmux
    '';
  };
}
