{
  # System-wide settings
  time.timeZone = "Asia/Kolkata";
  
  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
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
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    NIXOS_OZONE_WL = "1";
    EDITOR = "nvim";
  };

  system.stateVersion = "23.11";
} 