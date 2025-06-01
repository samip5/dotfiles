{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.modules.program.jetbrain.toolbox;
in {
  options.modules.program.jetbrain.toolbox = { enable = mkEnableOption "jetbrain-toolbox"; };

  config = mkIf cfg.enable {
    home.manager.home.packages = [ pkgs.jetbrains-toolbox ];
  };
}
