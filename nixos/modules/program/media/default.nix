{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.program.media;
in
{
  options.modules.program.media = {
    jellyfinplayer.enable = lib.mkEnableOption "Jellyfin Media Player";
    spotify.enable = lib.mkEnableOption "Spotify";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.jellyfinplayer.enable {
      home.manager.home.packages = [ pkgs.jellyfin-media-player ];
    })

    (lib.mkIf cfg.spotify.enable {
      home.manager.home.packages = [ pkgs.spotify ];
    })
  ];
}
