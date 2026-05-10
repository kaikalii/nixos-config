{ config, pkgs, ... }:

{
  home = {
    username = "kai";
    homeDirectory = "/home/kai";
    stateVersion = "25.05";
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
    };
    packages = with pkgs; [
      vscode-fhs
      discord
      nixfmt
      gnomeExtensions.dash-to-panel
    ];
  };
  programs = {
    firefox = {
      enable = true;
      profiles.default = {
        isDefault = true;
        path = "default";
        settings = {
          "browser.startup.page" = 1;
          "browser.sessionstore.resume_from_crash" = true;
        };
      };
    };
    bash.enable = true;

  };
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [ "dash-to-panel@jderose9.github.com" ];
      enable-hot-corners = false;
    };
    "org/gnome/shell/extensions/dash-to-panel" = {
      panel-position = "BOTTOM";
      show-apps-icon = false;
      show-favorites = true;
      show-activities = false;
      multi-monitors = true;
    };
  };
}
