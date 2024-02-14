{pkgs, config, ...}:
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
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
          size = 5;
          passes = 2;
          vibrancy = 0.5;
        };
      };
      exec-once = [ "${pkgs.fcitx5}/bin/fcitx5 -d" ];
      # Set mod key to super
      "$mod" = "SUPER";

      # Move apps with the mouse

      windowrule = ["tile,title:^(Minecraft)(.*)$"];
      # Enable workspace swipe
      gestures.workspace_swipe = "yes";
      binde = [
        # Volume Up and Down keybinds
        ", XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer --decrease 5"
        ", XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer --increase 5"
      ];
      bind = [
        ''$mod, S, exec, ${pkgs.hyprland}/bin/hyprctl keyword bind ", Escape, exec, eww close shutdown"''
        ''$mod, S, exec, ${pkgs.hyprland}/bin/hyprctl keyword bind ", Escape, exec, hyprctl keyword unbind ,Escape"''
        "$mod, S, exec, ${pkgs.eww-wayland}/bin/eww open shutdown"
        # Screenshot keybind
        '',Print,exec,${pkgs.grim}/bin/grim -c -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f -''
        # Binds to move between workspaces

        # Start rofi app launcher
        "$mod, D, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun -show-icons"

        # Start alacritty
        "$mod, T, exec, ${pkgs.alacritty}/bin/alacritty"

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
    extraConfig = ''
        bind=CTRL ALT, left, workspace, e-1
        bind=CTRL ALT, right, workspace, e+1
        bind=CTRL ALT SHIFT, left, movetoworkspace, e-1
        bind=CTRL ALT SHIFT, right, movetoworkspace, e+1

        
        # Close app
        bind=$mod, C, killactive

        # Move focus keybinds
        bind=$mod, left, movefocus, l
        bind=$mod, right, movefocus, r
        bind=$mod, up, movefocus, u
        bind=$mod, down, movefocus, d

        # Mouse bindings
        bind=$mod, M, submap, mouse
        submap=mouse
        bindm=$mod,mouse:272,movewindow
        bindm=$mod,mouse:273,resizewindow
        bind=$mod, M, submap, reset
        submap=reset
    '';
  };
}
