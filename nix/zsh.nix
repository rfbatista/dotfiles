{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "vi-mode" "git" "python" "history-substring-search" "tmux"];
    };
    interactiveShellInit = ''
      eval "$(starship init zsh)"
    '';
  };
  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };
  environment.variables = let
    starshipConfToml =
      pkgs.writeText "starship.toml" ''
        [[battery.display]]
        threshold = 50
      '';
  in {
    STARSHIP_CONFIG = "${starshipConfToml}";
  };
}

