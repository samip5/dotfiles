{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.modules.program.net-utils;
in {
  options.modules.program.net-utils = {
    nmap.enable = mkEnableOption "The Network Mapper";
    mikrotik = mkOption {
      type = types.submodule {
        options.winbox4 = mkOption {
          type = types.submodule {
            options.enable = mkEnableOption "Mikrotik Winbox4";
          };
        };
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.mikrotik.winbox4.enable {
      home.manager.home.packages = [ pkgs.winbox4 ];
    })
    (lib.mkIf cfg.nmap.enable {
      home.manager.home.packages = [ pkgs.nmap ];
    })
  ];

}
