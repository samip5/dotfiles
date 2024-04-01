{ pkgs, lib, config, ... }:

{
  imports = [
    ./gaming.nix
    ./graphic.nix
    ./gui-utils.nix
    ./tor.nix
    ./media.nix
    ./tui-utils.nix
    ./plex.nix
  ];
}
