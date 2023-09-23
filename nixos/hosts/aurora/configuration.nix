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
        monitors = [
         { name = "DP-1"; width = "1920"; height = "1080"; }
        ];
        hasBluetooth = true;
        hasSound = true;
        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAR0zt/ie+TMD+bY3wxfzbNNbAPH6NFJmC1AA066fsDr sky@Ryzen-Gaming-Gentoo"
        ];
      };

      #browser.opera.enable = true;
      browser.firefox.enable = true;

      #editor.neovim.enable = true;
      editor.geany.enable = true;

      #monitoring.smartd.enable = true;

      # multiplexer.tmux.enable = true;
      # multiplexer.zellij.enable = true;

      program.discord.enable = true;
      #program.netmanager.enable = true;
      program.graphic.enable = true;
      program.gui-utils.enable = true;
      program.libreoffice.enable = true;
      program.media.enable = true;
      #program.nextcloud.enable = true;
      shell.fish.enable = true;
      shell.git.enable = true;
      shell.lf.enable = true;
      shell.openssh.enable = true;

      # windowmanager.hyprland.enable = true;
      # windowmanager.sway.enable = true;
      desktopmanager.plasma.enable = true; 
     };

     sops = {
       defaultSopsFile = ./secret.sops.yaml;
       age.keyFile = "${config.home.manager.home.homeDirectory}/.config/sops/age/keys.txt";
     };

     environment.variables.FLAKE = "${config.home.manager.home.homeDirectory}/code/Github/samip5/dotfiles";
     services.greetd.enable = false;
     services.xserver.libinput.enable = true;

     boot = {
       initrd = {
         luks = {
          devices = {
           luksroot = {
             device = "UUID=caaa4bb9-4464-4849-aa87-5a62d10faecc";
             preLVM = true;
             allowDiscards = true;
           };
          };
         };
       };
       loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
          netbootxyz.enable = true;
        };
        efi.efiSysMountPoint = "/boot";
        efi.canTouchEfiVariables = true;
      };
     };     

   };
}

