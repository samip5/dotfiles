{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.modules.program.jellyfinmediaplayer;
in {
  options.modules.program.jellyfinmediaplayer = { enable = mkEnableOption "jellyfinmediaplayer"; };

  config = mkIf cfg.enable {
    home.manager.home.packages = [ pkgs.jellyfinmediaplayer ];
  };
}
