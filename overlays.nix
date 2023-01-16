{ config, pkgs, ... }:
{
  nixpkgs.overlays = [
    (
    self: super: {
      neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: {
        version = "master";
        src = super.fetchFromGitHub {
          owner = "neovim";
          repo = "neovim";
          rev = "4bc74c24318a544f30a9d2431dbd969f9d5cd0f5";
          sha256 = "0ydydvgi4lyvwsq58ljva5jy8hv2x0gv3mr04pk6wb0c35ilxp0k";
        };
        buildInputs = oldAttrs.buildInputs ++ [ super.tree-sitter ];
      });
    }
    )
  ];
}
