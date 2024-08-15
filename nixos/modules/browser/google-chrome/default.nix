{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.modules.browser.google-chrome;
  device = config.modules.device;
in {
  options.modules.browser.google-chrome = { enable = mkEnableOption "google-chrome"; };

  config = mkIf cfg.enable {
    home.manager = {
      programs.google-chrome = {
        enable = true;
      };
    };
  };
}
