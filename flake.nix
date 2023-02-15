{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.neovim-flake.url = "github:neovim/neovim/v0.8.0?dir=contrib";
  };

  outputs = { self, nixpkgs, home-manager, neovim-nightly-overlay }:
    let
      system = "x86_64-linux";
      username = "rfbatista";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          neovim-nightly-overlay.overlay
          ( self: super: {
            libvterm-neovim = super.libvterm-neovim.overrideAttrs(old: {
              version = "0.3";
              src = builtins.fetchTarball {
                url = "https://www.leonerd.org.uk/code/libvterm/libvterm-0.3.tar.gz";
                sha256 = "0zg6sn5brwrnqaab883pdj0l2swk5askbbwbdam0zq55ikbrzgar";
              };
            });
          })
        ];
      };
      lib = nixpkgs.lib;
    in { 


      homeConfigurations = {
        rfbatista = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
              ./home.nix
            ];
        };
      };

      nixosConfigurations = {
        rfbatista = nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          modules = [
            ./configuration.nix
            ./programs.nix
            ./networking.nix
            ./docker.nix
            ./environment.nix
            ./tmux.nix
            ./zsh.nix
            ./services.nix
          ];
        };
      };

    };
  
}
