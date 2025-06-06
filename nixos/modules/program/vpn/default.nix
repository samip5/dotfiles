{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.modules.program.tailscale;
in {
  options.modules.program.tailscale = { enable = mkEnableOption "taiscale"; };

  config = mkIf cfg.enable {
    home.manager.home.packages = [ pkgs.tailscale ];
  };
}

