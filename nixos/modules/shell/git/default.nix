{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.shell.git;
in {
  options.modules.shell.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable {
    home.manager = {
      programs.git = {
        enable = true;
        userName = "samip5";
        userEmail = "sm+git@skym.fi";
        extraConfig = {
          commit = {
            template = "${./gitcommit-message}";
            gpgSign = true;
          };
          user = {
            signingKey = "/home/${config.modules.device.username}/.ssh/id_ed25519.pub";
          };
          gpg = {
            format = "ssh";
          };
        };
      };

      programs.gh.enable = true;
    };
  };
}
