{ config, pkgs, ... }:
{
  environment.variables = {
    SYS_THEME = "dark";
    VI_CONFIG = "~/.config/nvim/init.vim";
    DOCKER_CONFIG = "/home/rfbatista/";
  };
  environment.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };
}
