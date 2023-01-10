{
  inputs = {
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.neovim-flake.url = "github:neovim/neovim/v0.7.0?dir=contrib";
  };

  outputs = { self, nixpkgs, neovim-nightly-overlay, ... }: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.rfbatista = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix 
        {
          nixpkgs.overlays = [
            (neovim-nightly-overlay.overlay)
          ];
        }
      ];
    };
  };
}
