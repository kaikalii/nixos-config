{ pkgs, ... }:
{
  imports = [
    ./zed.nix
  ];
  home = {
    username = "kai";
    homeDirectory = "/home/kai";
    stateVersion = "25.05";
    enableNixpkgsReleaseCheck = false;
    shellAliases = {
      reload = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
    };
    packages = with pkgs; [
      # Desktop
      gnomeExtensions.dash-to-panel
      # Apps
      zed-editor
      discord
      modrinth-app
      rimsort
      # Utils
      nixfmt
      nil
      nixd
    ];
    sessionPath = [
      "$HOME/.cargo/bin"
    ];
  };
  programs = {
    bash.enable = true;
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
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
    };
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
