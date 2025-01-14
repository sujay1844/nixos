{ pkgs, pkgs-unstable, nixvim-config, system, ... }:

let unstable = pkgs-unstable;
in {
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
    nix-ld.enable = true;
  };
  environment.systemPackages = with pkgs; [
    nixvim-config.packages.${system}.default
    # Essentials
    busybox
    curl
    dig
    docker
    gcc
    git
    git-lfs
    iputils
    libnotify
    openssh
    parallel
    vim
    wget
    zip

    # Modern utils
    bat
    btop
    delta
    entr
    eza
    fastfetch
    fd
    fish
    fzf
    gh
    jq
    lazygit
    litecli
    mprocs
    ncdu
    pbzip2
    pigz
    pxz
    pzip
    ripgrep
    starship
    stow
    thefuck
    yazi
    zellij

    # Dev
    corepack
    go
    google-cloud-sdk
    nodejs_22
    poetry
    python3
    unstable.mongodb-compass

    # System utilities
    acpi
    appimage-run
    bitwarden-cli
    croc
    gparted
    input-remapper
    magic-wormhole
    oath-toolkit
    pv
    rclone
    rsync
    sshfs
    syncthing
    unstable.alacritty
    wl-clipboard
    zoxide

    # Applications
    bitwarden-desktop
    brave
    cozy
    libreoffice
    mpv
    signal-desktop
    tor-browser
    unstable.code-cursor
    unstable.microsoft-edge
    unstable.obsidian
    unstable.qbittorrent
    unstable.ticktick
    unstable.vscode-fhs
    zed-editor

    # Desktop Environment
    gnome-terminal
    gnome-tweaks
    gnomeExtensions.pop-shell
    qogir-icon-theme
    qogir-kde
    qogir-theme
    tela-icon-theme
  ];
}
