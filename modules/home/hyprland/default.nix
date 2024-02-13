{pkgs, config, ...}:
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      general = let inherit (config.colorScheme.palette) base00 base01 base0A;
      in {
        "col.active_border" = "rgba(${base01}ff) rgba(${base0A}ff) 45deg";
        "col.inactive_border" = "rgba(${base00}ff)";
        "border_size" = 2;
      };
      "input" = {
        kb_layout = "pt,jp";
        kb_variant = "anthy";
        kb_options = "grp:win_space_toggle";
        touchpad.natural_scroll = "yes";
        touchpad.disable_while_typing = false;
      };
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      exec-once = [ "${pkgs.fcitx5}/bin/fcitx5 -d" ];
      # Set mod key to super
      "$mod" = "SUPER";

      # Move apps with the mouse
      bindm = [ "$mod,mouse:272,movewindow" "$mod,mouse:273,resizewindow" ];

      windowrule = ["tile,title:^(Minecraft)(.*)$"];
      # Enable workspace swipe
      gestures.workspace_swipe = "yes";
      binde = [
        # Volume Up and Down keybinds
        ", XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer --decrease 5"
        ", XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer --increase 5"
      ];
      bind = [
        ''$mod, S, exec, hyprctl keyword bind ", Escape, exec, eww close shutdown"''
        ''$mod, S, exec, hyprctl keyword bind ", Escape, exec, hyprctl keyword unbind ,Escape"''
        "$mod, S, exec, eww open shutdown"
        # Screenshot keybind
        ", Print, exec, ${pkgs.grimblast}/bin/grimblast copy area"
        # Binds to move between workspaces
        "CTRL ALT, left, workspace, e-1"
        "CTRL ALT, right, workspace, e+1"
        "CTRL ALT SHIFT, left, movetoworkspace, e-1"
        "CTRL ALT SHIFT, right, movetoworkspace, e+1"

        # Reload eww bind
        "$mod, R, exec, ${
          pkgs.writeShellScript "reset-eww" ''
            pkill eww
            eww open bar
          ''
        }"

        # Start rofi app launcher
        "$mod, D, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun -show-icons"

        # Start alacritty
        "$mod, T, exec, ${pkgs.alacritty}/bin/alacritty"

        # Close app
        "$mod, C, killactive"

        # Move focus keybinds
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
      ] ++ (
        # Workspace keybind
        # $mod + {1..10} to workspace {1..10}
        # $mod + shift + {1..10} to move to workspace {1..10}
        builtins.concatLists (builtins.genList (x:
          let
            ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]) 10));
    };
  };
}