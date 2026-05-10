{ config, pkgs, ... }:

{
  home = {
    username = "kai";
    homeDirectory = "/home/kai";
    stateVersion = "25.05";
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
    };
  };
  programs = {
    firefox = {
      enable = true;
      profiles.default = {
        isDefault = true;
        settings = {
          "browser.startup.page" = 1;
          "browser.sessionstore.resume_from_crash" = true;
        };
      };
    };
    bash.enable = true;
  };
}