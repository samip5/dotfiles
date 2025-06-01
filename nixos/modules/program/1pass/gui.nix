{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.modules.program.1pass.gui;
in {
  options.modules.program.1pass.gui = { enable = mkEnableOption "1pass-gui"; };

  config = mkIf cfg.enable {
    home.manager.home.packages = [ pkgs._1password-gui ];
  };
}
