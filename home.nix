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
      git-fix = "git add --all && git commit --amend --no-edit && git push -f";
    };
    packages = with pkgs; [
      # Desktop
      gnomeExtensions.dash-to-panel
      gnomeExtensions.night-theme-switcher
      # Apps
      zed-editor
      discord
      modrinth-app
      rimsort
      spotify
      python3
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
      enabled-extensions = [
        "dash-to-panel@jderose9.github.com"
        "nightthemeswitcher@romainvigier.fr"
      ];
      enable-hot-corners = false;
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "org.gnome.Console.desktop"
        "firefox.desktop"
        "dev.zed.Zed.desktop"
        "discord.desktop"
        "spotify.desktop"
        "org.gnome.Settings.desktop"
      ];
    };
    "org/gnome/shell/extensions/dash-to-panel" = {
      panel-position = "BOTTOM";
      show-apps-icon = false;
      show-favorites = true;
      show-activities = false;
      multi-monitors = true;
    };
  };

  home.file.".config/autostart/discord.desktop".text = ''
    [Desktop Entry]
    Name=Discord
    Exec=${pkgs.discord}/bin/discord --start-minimized
    Type=Application
    Categories=Network;InstantMessaging;
  '';
}
