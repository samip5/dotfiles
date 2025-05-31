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

    services.displayManager.sddm.enable = true;
    services.displayManager.defaultSession = "plasma";
    services.displayManager.autoLogin.enable = false;

    services.xserver = {
      enable = true;
      desktopManager = {
        plasma6.enable = true;
        xterm.enable = false;
        runXdgAutostartIfNone = true;
      };
    };
  };
}
