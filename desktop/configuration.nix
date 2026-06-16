{ config, ... }:
{
  imports = [
    ../configuration.nix
  ];

  # Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    dynamicBoost.enable = false;
    videoAcceleration = true;
  };

  boot.kernelParams = [ "nvidia_drm.modeset=1" ];
}
