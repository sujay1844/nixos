{
  description = "Main NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixvim-config = { url = "github:sujay1844/nixvim"; };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nixvim-config, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = { allowUnfree = true; };
      };
    in
    {
      nixosConfigurations = {
        stormbreaker = nixpkgs.lib.nixosSystem {

          specialArgs = {
            inherit system;
            inherit pkgs;
            inherit pkgs-unstable;
            inherit inputs;
            inherit nixvim-config;
          };
          modules = [ ./configuration.nix ];
        };
      };
    };
}
