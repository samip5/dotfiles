{
  # resize window (you can also use the mouse for that)
  "$mode_resize" = {
    "h" = "resize shrink width 10 px or 10 ppt";
    "j" = "resize shrink height 10 px or 10 ppt";
    "k" = "resize grow height 10 px or 10 ppt";
    "l" = "resize grow width 10 px or 10 ppt";
    # same bindings, but for the arrow keys
    "Left" = "resize shrink width 10 px or 10 ppt";
    "Down" = "resize shrink height 10 px or 10 ppt";
    "Up" = "resize grow height 10 px or 10 ppt";
    "Right" = "resize grow width 10 px or 10 ppt";
    # back to normal: Enter or Escape
    "Return" = "mode default";
    "Escape" = "mode default";
  };
  # resize gaps
  "$mode_gaps" = {
    "o" = "mode \"$mode_gaps_outer\"";
    "i" = "mode \"$mode_gaps_inner\"";
    "Return" = "mode \"$mode_gaps\"";
    "Escape" = "mode default";
  };
  "$mode_gaps_outer" = {
    "k" = "gaps outer current plus 5";
    "j" = "gaps outer current minus 5";
    # same bindings, but for the arrow keys
    "Up" = "gaps outer current plus 5";
    "Down" = "gaps outer current minus 5";
    "Shift+k" = "gaps outer all plus 5";
    "Shift+j" = "gaps outer all minus 5";
    # same keybindings, but for the arrow keys
    "Shift+Up" = "gaps outer all plus 5";
    "Shift+Down" = "gaps outer all minus 5";
    "Return" = "mode \"$mode_gaps\"";
    "Escape" = "mode default";
  };
  "$mode_gaps_inner" = {
    "k" = "gaps inner current plus 5";
    "j" = "gaps inner current minus 5";
    # same bindings, but for the arrow keys
    "Up" = "gaps inner current plus 5";
    "Down" = "gaps inner current minus 5";
    "Shift+k" = "gaps inner all plus 5";
    "Shift+j" = "gaps inner all minus 5";
    # same keybindings, but for the arrow keys
    "Shift+Up" = "gaps inner all plus 5";
    "Shift+Down" = "gaps inner all minus 5";
    "Return" = "mode \"$mode_gaps\"";
    "Escape" = "mode default";
  };
  # Press Ctrl+Alt+Delete will show log out menu
  "$mode_system" = {
    "l" = "exec --no-startup-id $Locker, mode default";
    "e" = "exec --no-startup-id i3-msg exit, mode default";
    "r" = "exec --no-startup-id systemctl reboot, mode default";
    "s" = "exec --no-startup-id systemctl poweroff -i, mode default";
    "f" = "exec --no-startup-id systemctl reboot --firmware-setup, mode default";
    # back to normal: Enter or Escape
    "Return" = "mode default";
    "Escape" = "mode default";
  };
  # take a screenshot with scrot, put it in Desktop folder
  "$mode_screenshot" = {
    "Return" = "exec --no-startup-id $scrot_capture && paplay ~/.config/i3/sounds/camera-shutter.oga && notify-send \"Screenshot saved in your Desktop folder\", mode default";
    "--release s" = "exec --no-startup-id $scrot_region && paplay ~/.config/i3/sounds/camera-shutter.oga && notify-send \"Screenshot saved in your Desktop folder\", mode default";
    "Escape" = "mode default";
  };
}
