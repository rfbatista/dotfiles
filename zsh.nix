{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "vi-mode" "git" "python" "history-substring-search" "tmux" ];
    };
  };
}

