{
  networking = {
    hostName = "stormbreaker";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [ 8384 22000 2283 ];
      allowedUDPPorts = [ 22000 21027 ];
    };
  };
}
