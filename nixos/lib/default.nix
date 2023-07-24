{ inputs, ... }: let
  inherit (inputs.nixpkgs) lib;
in {
  mkNixosSystem = system: hostname: username:
    lib.nixosSystem {
      inherit system;
      pkgs = import inputs.nixpkgs {
        inherit system;
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
            pkgs-stable = import inputs.nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
              overlays = [ (import ../packages/overlay.nix {inherit inputs system;}) ];
            };
          };
        }
        inputs.home-manager.nixosModules.home-manager
        inputs.nur.nixosModules.nur
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
