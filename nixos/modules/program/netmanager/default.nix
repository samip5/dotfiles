{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.modules.program.netmanager;
in {
  options.modules.program.netmanager = { enable = mkEnableOption "netmanager"; };

  config = mkIf cfg.enable {
    home.manager.home.packages = [ pkgs.networkmanager ];
  };
}
