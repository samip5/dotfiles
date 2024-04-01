{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.modules.program.tor;
in {
  options.modules.program.tor = { enable = mkEnableOption "tor"; };

  config = mkIf cfg.enable {
    home.manager.home.packages = with pkgs; [
      tor-browser
    ];
  };
}
