{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.modules.program.plex;
in {
  options.modules.program.plex = { enable = mkEnableOption "default plex"; };

  config = mkIf cfg.enable {
    home.manager.home.packages = with pkgs; [
      plex-media-player
      plex-mpv-shim
    ];
  };
}
