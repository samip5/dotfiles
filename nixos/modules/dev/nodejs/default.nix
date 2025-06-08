{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.program.dev.nodejs22;
in
{
  options.modules.program.dev.nodejs22 = { enable = lib.mkEnableOption "NodeJS v22"; };

   config = mkIf cfg.enable {
    home.manager.home.packages = [ pkgs.nodejs22 ];
   };
}
