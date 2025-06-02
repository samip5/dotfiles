{ inputs, ... }: let
  inherit (inputs.nixpkgs) lib;
in {
  mkNixosSystem = system: hostname: username:
    lib.nixosSystem {
      inherit system;
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.permittedInsecurePackages = [
          "olm-3.2.16"
        ];
        config.allowUnfree = true;
        overlays = [
          (import ../packages/overlay.nix {inherit inputs system;})
          inputs.nh.overlays.default
        ];
      };
      modules = [
        {
          _module.args = {
            inherit inputs system;
            myConfig = { hostname = hostname; username = username; };
            myPkgs = inputs.self.legacyPackages.${system};
            pkgs-unstable = import inputs.nixpkgs-unstable {
              inherit system;
              config.permittedInsecurePackages = [
                 "olm-3.2.16" 
              ];
              config.allowUnfree = true;
              overlays = [ (import ../packages/overlay.nix {inherit inputs system;}) ];
            };
          };
        }
        inputs.home-manager.nixosModules.home-manager
        inputs.nur.modules.nixos.default
        inputs.sops-nix.nixosModules.sops
        inputs.hyprland.nixosModules.default
        # Load the modules
        ../modules
        # Default configuration
        ../hosts/configuration.nix
        # Host specific configuration
        ../hosts/${hostname}/configuration.nix
        # Host specific hardware configuration
        ../hosts/${hostname}/hardware-configuration.nix
      ];
    };
}
