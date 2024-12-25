{ config, pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = true;
    kernelParams = [ "btusb.autosuspend=n" "usbcore.autosuspend=-1" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback.out ];
    kernelModules = [ "v4l2loopback" "snd_aloop" ];
    extraModprobeConfig = ''
      options v4l2loopback card_label="Virtual Camera" 
    '';
  };

  # To run AppImages directly
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
    magicOrExtension = "\\x7fELF....AI\\x02";
  };
}
