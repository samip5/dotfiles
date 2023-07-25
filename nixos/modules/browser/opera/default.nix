{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.browser.opera;
  device = config.modules.device;
in {
  options.modules.browser.opera = { enable = mkEnableOption "opera"; };

  config = mkIf cfg.enable {
    home.manager = {
      programs.opera = {
        enable = true;
      };
    };
  };
}
