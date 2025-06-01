{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.modules.program.onepass.cli;
in {
  options.modules.program.onepass.cli = { enable = mkEnableOption "onepass.cli"; };

  config = mkIf cfg.enable {
    home.manager.home.packages = [ pkgs._1password-cli ];
  };
}
