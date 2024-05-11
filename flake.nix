{
	description = "Main NixOS Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
		nixos-unstable.url = "github:nixos/nixpkgs-channels?ref=nixos-unstable";
	};

	outputs = { self, nixpkgs, nixos-unstable }:
	let 
		system = "x86_64-linux";
		pkgs = import nixpkgs {
			inherit system;

			config = {
				allowUnfree = true;
			};
		};

	in {
		nixosConfigurations = {
			stormbreaker = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit system; };
				modules = [
					./configuration.nix
				];
			};
		};
	};
}

