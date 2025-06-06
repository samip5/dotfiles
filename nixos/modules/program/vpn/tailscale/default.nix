{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.modules.program.vpn.tailscale;
in {
  options.modules.program.vpn.tailscale = { enable = mkEnableOption "taiscale"; };

  config = mkIf cfg.enable {
    home.manager.home.packages = [ pkgs.tailscale ];
  };
}
