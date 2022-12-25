{ config, lib, pkgs, ... }:

with lib;

let

  config.programs.neovim = {
	enable = true;


  };
