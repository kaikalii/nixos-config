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

  outputs =
    {
      nixpkgs,
      home-manager,
      rust-overlay,
      ...
    }:
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kai = import ./home.nix;
                backupFileExtension = "backup";
              };
            }
            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [ rust-overlay.overlays.default ];
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
      };
    };
}
