{ config, pkgs, ... }:

{
  home.username = "kai";
  home.homeDirectory = "/home/kai";
  home.stateVersion = "25.05";
  programs.bash.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
  };
}