{ config, pkgs, ... }: {
  # Enable basic services
  services = {
    printing.enable = true;
    syncthing = {
      enable = true;
      user = "sujay1844";
      dataDir = "/home/sujay1844";
      configDir = "/home/sujay1844/.config/syncthing";
    };
  };

  # Security and system services
  security = {
    rtkit.enable = true;
    sudo.enable = true;
  };

  # Virtualization
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      enableOnBoot = false;
    };
    libvirtd.enable = true;
  };

  powerManagement.enable = true;
}
