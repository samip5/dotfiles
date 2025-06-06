{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.program.jetbrains;
in
{
  options.modules.program.jetbrains = {
    toolbox.enable = lib.mkEnableOption "JetBrains Toolbox";
    idea.enable = lib.mkEnableOption "IntelliJ IDEA";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.toolbox.enable {
      home.manager.home.packages = [ pkgs.jetbrains-toolbox ];
    })

    (lib.mkIf cfg.idea.enable {
      home.manager.home.packages = [ pkgs.jetbrains.idea-ultimate ];
    })
  ];
}
