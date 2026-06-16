{ pkgs, hostName, ... }:
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
      reload = "sudo nixos-rebuild switch --flake ~/nixos-config#${hostName}";
      git-fix = "git add --all && git commit --amend --no-edit && git push -f";
      zed = "zeditor";
    };
    packages = with pkgs; [
      # Desktop
      gnomeExtensions.dash-to-panel
      gnomeExtensions.night-theme-switcher
      gnomeExtensions.quick-settings-audio-devices-renamer
      gnomeExtensions.quick-settings-audio-devices-hider
      gnomeExtensions.tiling-shell
      gnomeExtensions.unblank
      # Apps
      zed-editor
      vscode
      audacity
      discord
      modrinth-app
      rimsort
      spotify
      fontforge-gtk
      gimp
      # Langs
      python3
      # Utils
      nil
      nixd
      nixfmt
    ];
    sessionPath = [
      "$HOME/.cargo/bin"
    ];
    sessionVariables = {
      PATH = "$HOME/.cargo/bin:$PATH";
    };
    file = {
      ".config/autostart/discord.desktop".text = ''
        [Desktop Entry]
        Name=Discord
        Exec=${pkgs.discord}/bin/discord
        Type=Application
        Categories=Network;InstantMessaging;
      '';
      ".local/share/applications/modrinth.desktop".text = ''
        [Desktop Entry]
        Name=Modrinth App
        Exec=env GDK_BACKEND=x11 WEBKIT_DISABLE_COMPOSITING_MODE=1 ${pkgs.modrinth-app}/bin/ModrinthApp %U
        Type=Application
        Categories=Game;
        Terminal=false
      '';
    };
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
          "browser.sessionstore.resume_from_crash" = false;
        };
      };
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
    };
    "org/gnome/desktop/background" = {
      picture-options = "spanned";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "dash-to-panel@jderose9.github.com"
        "nightthemeswitcher@romainvigier.fr"
        "quicksettings-audio-devices-hider@marcinjahn.com"
        "quicksettings-audio-devices-renamer@marcinjahn.com"
        "tilingshell@ferrarodomenico.com"
        "unblank@sun.wxg@gmail.com"
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
      multi-monitors = false;
    };
  };
}
