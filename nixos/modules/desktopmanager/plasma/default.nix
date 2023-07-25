{ pkgs, lib, config, myPkgs, ... }:
with lib;
let
  cfg = config.modules.desktopmanager.plasma;
  device = config.modules.device;
in {
  options.modules.desktopmanager.plasma = { enable = mkEnableOption "plasma"; };

  config = mkIf cfg.enable {
    modules.system.sound.enable = true;
    modules.system.video.enable = true;

    services.xserver = {
      enable = true;
      displayManager = {
         autoLogin.enable = false;
         defaultSession = "plasma";
         sddm = {
           enable = true;
         };
      };
      desktopManager = {
        plasma5.enable = true;
        xterm.enable = false;
        runXdgAutostartIfNone = true;
      };
    };
  };
}