{
  description = "Kai's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = args: {
    nixosConfigurations =
      let
        host =
          args: name:
          args.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              hostName = name;
            };
            modules = [
              ./${name}/configuration.nix
              ./${name}/hardware-configuration.nix
              args.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  extraSpecialArgs = {
                    hostName = name;
                  };
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.kai = import ./home.nix;
                  backupFileExtension = "backup";
                };
              }
              (
                { pkgs, ... }:
                {
                  nixpkgs.overlays = [ args.rust-overlay.overlays.default ];
                  environment.systemPackages = [
                    (pkgs.rust-bin.stable.latest.default.override {
                      targets = [
                        "x86_64-unknown-linux-gnu"
                        "wasm32-unknown-unknown"
                        "wasm32-wasip2"
                      ];
                      extensions = [ "rust-src" ];
                    })
                  ];
                }
              )
            ];
          };
      in
      {
        laptop = host args "laptop";
        desktop = host args "desktop";
      };
  };
}
