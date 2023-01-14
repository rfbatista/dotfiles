build:
	sudo nixos-rebuild switch --flake '.#rfbatista'
home:
	 nix build --no-link .#homeConfigurations.rfbatista.activationPackage
check:
	nix-store --query --requisites /run/current-system | cut -d- -f2- | sort -u | grep neovim
ch:
	ls -lt --time=birth /nix/store/ | grep neovim
