{
  description = "My NixOS configurations IaC";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Lix - Substitution of the Nix package manager, focused on correctness, usability, and growth – and committed to doing right by its community.
    # https://git.lix.systems/lix-project/lix
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # impermanence
    # https://github.com/nix-community/impermanence
    impermanence.url = "github:nix-community/impermanence";

    # Nix User Repository: User contributed nix packages
    nur.url = "github:nix-community/NUR";

    # nix-community hardware quirks
    # https://github.com/nix-community
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # disko - Declarative disk partitioning and formatting using nix
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager - Manage user configuration with nix
    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # sops-nix - secrets with mozilla sops
    # https://github.com/Mic92/sops-nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # homeage: runtime decrypted age secrets for nix home manager
    homeage = {
       url = "github:jordanisaacs/homeage";
       inputs.nixpkgs.follows = "nixpkgs";
    };

    talhelper = {
       url = "github:budimanjojo/talhelper";
       inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    hyprland.url = "github:hyprwm/Hyprland";

    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops-nix, home-manager, impermanence, disko, talhelper, lix-module, flake-parts, ... }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
              "aarch64-linux"
              "x86_64-linux"
      ];
    in
    rec {
      formatter = forAllSystems (system: nixpkgs.legacyPackages."${system}".nixpkgs-fmt);

      lib = nixpkgs.lib.extend ( final: prev: {
         inherit inputs;
         myLib = import ./nixos/lib/default.nix { inherit inputs; lib = final; };
         }
      );
    }
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem = {
        inputs',
        pkgs,
        ...
      }: {
        legacyPackages = import ./nixos/packages { inherit inputs' pkgs; };
        devShells.default = import ./nixos/packages/shell.nix { inherit pkgs; };
      };

      flake.nixosConfigurations = {
        aurora = myLib.mkNixosSystem "x86_64-linux" "aurora" "sky";
      };
    };
}
