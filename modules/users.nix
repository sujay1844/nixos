{ pkgs, ... }: {
  users.users.sujay1844 = {
    isNormalUser = true;
    description = "sujay1844";
    extraGroups = [ "networkmanager" "wheel" "docker" "input" "uinput" "adbusers" ];
    shell = pkgs.fish;
  };
}
