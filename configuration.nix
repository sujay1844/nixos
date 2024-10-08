# Edt this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, pkgs-unstable, nixvim-config, config, system, ... }:

let unstable = pkgs-unstable;
in {
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;
  boot.kernelParams = [ "btusb.autosuspend=n" ];
  boot.extraModulePackages = with config.boot.kernelPackages;
    [ v4l2loopback.out ];
  boot.kernelModules = [ "v4l2loopback" "snd_aloop" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback card_label="Virtual Camera" 
  '';

  networking.hostName = "stormbreaker"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    # Enable the GNOME Desktop Environment.
    desktopManager.gnome.enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.sudo.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  services.syncthing = {
    enable = true;
    user = "sujay1844";
    dataDir = "/home/sujay1844";
    configDir = "/home/sujay1844/.config/syncthing";
  };
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    enableOnBoot = false;
  };
  powerManagement.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sujay1844 = {
    isNormalUser = true;
    description = "sujay1844";
    extraGroups =
      [ "networkmanager" "wheel" "docker" "input" "uinput" "adbusers" ];
    shell = pkgs.fish;
    # packages = with pkgs; [ ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  # };
  programs.fish.enable = true;
  programs.adb.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    NIXOS_OZONE_WL = "1";
    EDITOR = "nvim";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nixvim-config.packages.${system}.default
    # Essentials
    vim
    git
    git-lfs
    wget
    curl
    gcc
    cargo
    docker
    openssh
    iputils
    busybox
    parallel
    zip

    # Modern utils
    fzf
    ripgrep
    fd
    bat
    eza
    fish
    btop
    starship
    gh
    entr
    delta
    thefuck
    jq
    ncdu
    fastfetch
    mprocs
    pzip
    pigz
    pbzip2
    pxz
    lazygit
    zellij
    unstable.mongodb-compass

    # System utilities
    input-remapper
    gparted
    unstable.alacritty
    pv
    acpi
    rsync
    sshfs
    croc
    oath-toolkit
    magic-wormhole
    wl-clipboard
    zoxide
    appimage-run
    rclone
    syncthing

    # Applications
    unstable.brave
    unstable.microsoft-edge
    unstable.vscode-fhs
    unstable.obsidian
    mpv
    qbittorrent
    tor-browser
    jetbrains.goland
    libreoffice
    cozy

    # Desktop Environment
    gnome.gnome-tweaks
    gnome.gnome-terminal
    gnomeExtensions.pop-shell
    qogir-icon-theme
    qogir-theme
    qogir-kde
    tela-icon-theme
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    (nerdfonts.override { fonts = [ "FiraCode" "SourceCodePro" ]; })
  ];

  # To run AppImages directly
  # https://nixos.wiki/wiki/Appimage
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
    magicOrExtension = "\\x7fELF....AI\\x02";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8384 22000 2283 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
