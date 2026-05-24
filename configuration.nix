# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  hostName,
  ...
}:

{
  imports = [
    ./musescore.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "kais_${hostName}"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  fonts = with pkgs; {
    packages = [ fira-code ];
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
    guiAddress = "0.0.0.0:8384"; # By default syncthing only listens to localhost
    user = "kai";
    dataDir = "/home/kai"; # Sets the base directory for syncthing data
    configDir = "/home/kai/.config/syncthing"; # Stores database/keys in your home
    settings = {
      gui.user = "kai";
      gui.password = "syncthing";
      devices = {
        "Desktop".id = "W7Q6455-YXY4XPX-7DAF3GR-DMG62DF-GZYJCN7-LN24LXB-RJWRXRC-EPNKZA2";
        "Laptop".id = "OZSWG6Z-PTZAEZ7-U2I3GN2-RJFCIES-QVA36ZI-TVAPK6Y-UJIC3JZ-VFTJIQI";
        "Phone".id = "P4775T7-R4CQIFP-VPFSVUS-V426EHK-O2NOCVV-G5YS7VS-QKNQCRO-D4GCTQU";
      };
      folders =
        let
          all_devices = [
            "Desktop"
            "Laptop"
            "Phone"
          ];
        in
        {
          "Pictures" = {
            path = "/home/kai/Pictures";
            id = "pictures";
            devices = all_devices;
          };
          "Documents" = {
            path = "/home/kai/Documents";
            id = "documents";
            devices = all_devices;
          };
        };
    };
  };

  # port 8384  is the default port to allow access from the network.
  networking.firewall.allowedTCPPorts = [ 8384 ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  hardware.graphics.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kai = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    initialPassword = "changeme";
  };

  environment.systemPackages = with pkgs; [
    wget
    gh
    home-manager
    curl
    starship
    gcc
    libffi
    gnumake
    pkg-config
    alsa-lib
    ripgrep
    htop
  ];

  programs = {
    firefox.enable = true;
    starship.enable = true;
    nix-ld.enable = true;
    vim.enable = true;
    git.enable = true;
    steam.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };

  # Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = pkgs.linuxPackages.nvidiaPackages.stable;
  };

  system.stateVersion = "25.11"; # Do not change this for any reason!

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
