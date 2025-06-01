{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.modules.program.onepass.gui;
in {
  options.modules.program.onepass.gui = { enable = mkEnableOption "onepass.gui"; };

  config = mkIf cfg.enable {
    home.manager.home.packages = [ pkgs._1password-gui ];
  };
}
