{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.modules.program.matrix;
in {
  options.modules.program.matrix = { enable = mkEnableOption "matrix"; };

  config = mkIf cfg.enable {
    home.manager.home.packages = [ pkgs-stable.nheko ];
  };
}
