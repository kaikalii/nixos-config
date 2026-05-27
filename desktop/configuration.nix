{ config, ... }:
{
  imports = [
    ../configuration.nix
  ];

  # Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      intelBusId = "0:02:0";
      nvidiaBusId = "1:00:0";
    };
  };

  boot.kernelParams = [ "nvidia_drm.modeset=1" ];
}
