{
	description = "Main NixOS Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
	};

	outputs = { self, nixpkgs }:
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
