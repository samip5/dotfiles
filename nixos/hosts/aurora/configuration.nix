# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:
{
  config = {
    modules = {
      # Device specific options
      device = {
        cpu = "intel";
        gpu = "intel";
        hasBluetooth = true;
        hasSound = true;
      };
 
      program.discord.enable = true;
      program.graphic.enable = true;
      program.gui-utils.enable = true;
      program.libreoffice.enable = true;
      program.media.enable = true;
      program.nextcloud.enable = true;
      shell.fish.enable = true;
      shell.git.enable = true;
      shell.lf.enable = true;
      shell.openssh.enable = true;

      windowmanager.hyprland.enable = true;
     };

     sops = {
       defaultSopsFile = ./secret.sops.yaml;
       age.keyFile = "${config.home.manager.home.homeDirectory}/.config/sops/age/keys.txt";
     };

     environment.variables.FLAKE = "${config.home.manager.home.homeDirectory}/code/Github/samip5/dotfiles";

     boot = {
       initrd = {
         luks = {
          devices = {
           device = "/dev/disk/by-uuid/caaa4bb9-4464-4849-aa87-5a62d10faecc";
           preLVM = true;
          };
         };
       };
       loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
        efi.efiSysMountPoint = "/boot";
        efi.canTouchEfiVariables = true;
      };
     };
   };
}

