{ config, pkgs, inputs, ... }:
let
  deviceCfg = config.modules.device;
in {
  #sops.secrets.sky-password = {
  #  sopsFile = ./secret.sops.yaml;
  #  neededForUsers = true;
  #};

  #users.mutableUsers = false;
  users.users.${deviceCfg.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "dialout" ];
    shell = pkgs.fish;
    initialPassword = "Lol12";
  };

  # I don't want auto-login on tty.
  #services.getty.autologinUser = deviceCfg.username;
  services.greetd = {
    #enable = true;
    settings = {
      initial_session.user = deviceCfg.username;
      default_session.user = deviceCfg.username;
      #default_session.command = ''
      #      ${pkgs.greetd.tuigreet}/bin/tuigreet \
      #        --time \
      #        --asterisks \
      #        --user-menu
      #'';
    };
  };

  #services.xserver.displayManager.autoLogin.user = deviceCfg.username;
  services.displayManager.autoLogin.user = deviceCfg.username;

  networking.hostName = deviceCfg.hostname;

  time.timeZone = "Europe/Helsinki";

  security = {
    sudo.wheelNeedsPassword = false;
    polkit.enable = true;
  };

  # Programs that should always be needed
  modules.program.tui-utils.enable = true;

  nix = {
    settings = {
      substituters = [
        "https://hyprland.cachix.org"
        "https://viperml.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "viperml.cachix.org-1:qZhKBMTfmcLL+OG6fj/hzsMEedgKvZVFRRAhq7j8Vh8="
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  system = {
    autoUpgrade = {
      enable = false;
      flake = builtins.toString ../../.;
    };
    stateVersion = "25.11";
  };

  documentation.nixos.enable = false;

  home.manager = {
    home = {
      username = deviceCfg.username;
      homeDirectory = "/home/" + deviceCfg.username;

      stateVersion = "25.11";
    };

    programs = {
      home-manager.enable = true;
    };
  };
}
