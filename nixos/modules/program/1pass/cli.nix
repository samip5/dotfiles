{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.modules.program.1pass.cli;
in {
  options.modules.program.1pass.cli = { enable = mkEnableOption "1pass-cli"; };

  config = mkIf cfg.enable {
    home.manager.home.packages = [ pkgs._1password-cli ];
  };
}
