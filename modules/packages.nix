{ pkgs, pkgs-unstable, nixvim-config, system, ... }:

let
  unstable = pkgs-unstable;
in {
  environment.systemPackages = with pkgs; [
    nixvim-config.packages.${system}.default
    # Essentials
    vim git git-lfs wget curl gcc cargo docker openssh iputils busybox parallel zip

    # Modern utils
    fzf ripgrep fd bat eza fish btop starship gh entr delta thefuck jq ncdu
    fastfetch mprocs pzip pigz pbzip2 pxz gitui zellij unstable.mongodb-compass

    # Dev
    python3 corepack go sqlite google-cloud-sdk poetry

    # System utilities
    input-remapper gparted unstable.alacritty pv acpi rsync sshfs croc
    oath-toolkit magic-wormhole wl-clipboard zoxide appimage-run rclone
    syncthing bitwarden-cli

    # Applications
    brave unstable.microsoft-edge unstable.vscode-fhs unstable.code-cursor
    unstable.obsidian mpv unstable.qbittorrent tor-browser jetbrains.goland
    libreoffice cozy signal-desktop bitwarden-desktop

    # Desktop Environment
    gnome.gnome-tweaks gnome.gnome-terminal gnomeExtensions.pop-shell
    qogir-icon-theme qogir-theme qogir-kde tela-icon-theme
  ];
} 