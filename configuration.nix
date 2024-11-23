{ pkgs, pkgs-unstable, nixvim-config, config, system, ... }:

let
  unstable = pkgs-unstable;
in
{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/networking.nix
    ./modules/services.nix
    ./modules/system.nix
    ./modules/users.nix
    ./modules/packages.nix
  ];

  # Enable basic programs
  programs = {
    firefox.enable = true;
    fish.enable = true;
    adb.enable = true;
    mtr.enable = true;
    virt-manager.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
