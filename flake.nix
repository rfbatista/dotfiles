{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, neovim-nightly-overlay }:
    let
      system = "x86_64-linux";
      username = "marcel";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
        ];
      };
      lib = nixpkgs.lib;
    in {
      homeConfigurations = {
        rfbatista = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs username;
          stateVersion = "21.05";
          homeDirectory = "/home/rfbatista";
          configuration = {
            imports = [
              ./home-manager/home.nix
            ];
          };
        };
      };

      nixosConfigurations = {
        rfbatista = nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          modules = [
            ./configuration.nix
          ];
        };
      };
    };
  
}
