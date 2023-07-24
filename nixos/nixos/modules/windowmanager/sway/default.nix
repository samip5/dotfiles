{ pkgs, lib, config, myPkgs, ... }:
with lib;
let 
  cfg = config.modules.windowmanager.sway;
  device = config.modules.device;
in {
  options.modules.windowmanager.sway = { enable = mkEnableOption "sway"; };

  config = mkIf cfg.enable {
    modules.device.isWayland = true;

    modules.windowmanager.add-on.blueman-applet.enable = true;
    modules.windowmanager.add-on.dunst.enable = true;
    modules.windowmanager.add-on.gnome-keyring.enable = true;
    modules.windowmanager.add-on.gtk-theme.enable = true;
    modules.windowmanager.add-on.nm-applet.enable = true;
    modules.windowmanager.add-on.pasystray.enable = true;
    modules.windowmanager.add-on.polkit-gnome.enable = true;
    modules.windowmanager.add-on.rofi.enable = true;
    modules.windowmanager.add-on.swayidle.enable = true;
    modules.windowmanager.add-on.thunar.enable = true;
    modules.windowmanager.add-on.waybar.enable = true;
    modules.windowmanager.add-on.xdg.enable = true;
    modules.system.font.enable = true;
    modules.system.sound.enable = true;
    modules.system.video.enable = true;

    modules.terminal-emulator.wezterm.enable = true;

    assertions = [
      {
        assertion = length device.monitors > 0;
        message = ''
          At least one monitor in the `config.modules.device.monitors` is
          needed to use Sway module.
        '';
      }
    ];

    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "${pkgs.sway}/bin/sway";
        };
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd ${pkgs.sway}/bin/sway";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      at-spi2-core
      libappindicator-gtk3
      libappindicator-gtk2
      libappindicator
      wl-clipboard
      xdg-utils
    ] ++ [
      myPkgs.configure-gtk
      myPkgs.rofi-firefox-wrapper
    ];

    programs.sway.enable = true;
    programs.sway.wrapperFeatures.gtk = true;

    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk ];
    };

    networking.networkmanager.enable = true;
    programs.dconf.enable = true;
    programs.xwayland.enable = true;

    home.manager = {
      wayland.windowManager.sway = {
        enable = true;
        package = null;
        extraConfigEarly =
          let
            mon1 = getAttr "name" (elemAt device.monitors 0);
            mon1width = getAttr "width" (elemAt device.monitors 0);
            mon2 = if length device.monitors >= 2 then getAttr "name" (elemAt device.monitors 1) else getAttr "name" (elemAt device.monitors 0);
            mon2width = if length device.monitors >= 2 then getAttr "width" (elemAt device.monitors 1) else getAttr "width" (elemAt device.monitors 0);
          in ''
            # VARIABLES ARE SET HERE
            # Modifier default to Super key. Alt key for window navigating
            set $super Mod4
            set $alt Mod1
            # Default applications
            set $terminal wezterm
            set $browser rofi-firefox-wrapper
            set $filemanager thunar
            # Mode string to show on bar
            set $resize Resize: (h/Left) width-, (j/Down) height-, (k/Up) height+, (l/Right) width+
            set $gaps Gaps (o) outer, (i) inner
            set $gaps_outer Outer Gaps (k/Up) grow locally, (K/Shift+Up) grow globally
            set $gaps_inner Inner Gaps (k/Up) grow locally, (K/Shift+Up) grow globally
            set $system System: (l) lock, (e) logout, (r) reboot, (s) shutdown (f) uefi
            set $screenshot Screenshot: (Enter) Full Screenshot, (S) Select Region
            # locker command
            set $Locker swaylock && sleep 1
            # grim command
            set $grim_capture GRIM_DEFAULT_DIR=~/Desktop grim
            set $grim_region GRIM_DEFAULT_DIR=~/Desktop grim -g "$(slurp)"
            # Workspace naming
            set $ws0 0
            set $ws1 1
            set $ws2 2
            set $ws3 3
            set $ws4 4
            set $ws5 5
            set $ws6 6
            set $ws7 7
            set $ws8 8
            set $ws9 9
            # Monitor placement
            set $monleft ${mon1}
            set $monright ${mon2}
            # Monitor width
            set $monleftwidth ${mon1width}
            set $monrightwidth ${mon2width}
            # Tokyonight Night colors
            set $border-color #A9B1D6
            set $bg-color #1A1B26
            set $inac-bg-color #1A1B26
            set $text-color #F7768E
            set $inac-text-color #A9B1D6
            set $urgent-bg-color #F7768E
            set $indi-color #7AA2F7
            set $urgent-text-color #A9B1D6
            # Title bar colors
            #                         border            background        text                indicator     decoration_border
            client.focused            $bg-color         $bg-color         $text-color         $indi-color   $border-color
            client.unfocused          $bg-color         $inac-bg-color    $inac-text-color    $indi-color   $border-color
            client.focused_inactive   $bg-color         $inac-bg-color    $inac-text-color    $indi-color   $border-color
            client.urgent             $urgent-bg-color  $urgent-bg-color  $urgent-text-color  $indi-color   $border-color
          '';
        config = {
          floating = {
            modifier = "Mod1";
            titlebar = false;
            border = 0;
          };
          window.border = 1;
          fonts = {
            names = [ "pango:UbuntuMono Nerd Font" ];
            size = 12.0;
          };
          focus = {
            wrapping = "yes";
            followMouse = true;
            newWindow = "smart";
          };
          input = {
            # Enable numlock on boot
            # Temporary fix for Firefox crashing on reload (https://bugzilla.mozilla.org/show_bug.cgi?id=1652820)
            "9494:26:CM_Storm_Keyboard_--_QuickFire_XT" = { xkb_numlock = "enable"; };
            "64562:647:JosefAdamcik_Sofle_Consumer_Control" = { xkb_numlock = "enable"; };
          };
          gaps.inner = 10;
          bars = [];
          keybindings = import ./configs/keybindings.nix;
          modes = import ./configs/modes.nix { inherit config; };
          workspaceOutputAssign = import ./configs/ws-outputs.nix;
          output = import ./configs/outputs.nix;
          window.commands = import ./configs/commands.nix;
          startup = import ./configs/startups.nix { inherit pkgs; };
        };
      };

      xdg.configFile."sway/wallpapers".source = ./wallpapers;
      xdg.configFile."sway/sounds".source = ./sounds;

      home.sessionVariables = {
        XDG_CURRENT_DESKTOP = "sway";
        GTK_USE_PORTAL = "1";
      };
      home.packages = with pkgs; [
        grim
        slurp
      ];
    };
  };
}
