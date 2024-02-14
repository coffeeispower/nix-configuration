{pkgs, config, inputs, ...}:
let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  hyprlandEventHandlers = pkgs.writeShellScript "hyprlandEventHandlers" ''
    event_workspace() {
      ${pkgs.eww-wayland}/bin/eww update currentworkspace=$WORKSPACENAME
    }

    event_focusedmon() {
      : # MONNAME WORKSPACENAME
    }

    event_activewindow() {
      : # WINDOWCLASS WINDOWTITLE
    }

    event_activewindowv2() {
      : # WINDOWADDRESS
    }

    event_fullscreen() {
      : # ENTER (0 if leaving fullscreen, 1 if entering)
    }

    event_monitorremoved() {
      : # MONITORNAME
    }

    event_monitoradded() {
      : # MONITORNAME
    }

    event_createworkspace() {
      : # WORKSPACENAME
    }

    event_destroyworkspace() {
      : # WORKSPACENAME
    }

    event_moveworkspace() {
      : # WORKSPACENAME MONNAME
    }

    event_activelayout() {
      : # KEYBOARDNAME LAYOUTNAME
    }

    event_openwindow() {
      : # WINDOWADDRESS WORKSPACENAME WINDOWCLASS WINDOWTITLE
    }

    event_closewindow() {
      : # WINDOWADDRESS
    }

    event_movewindow() {
      : # WINDOWADDRESS WORKSPACENAME
    }

    event_windowtitle() {
      : # WINDOWADDRESS
    }

    event_openlayer() {
      : # NAMESPACE
    }

    event_closelayer() {
      : # NAMESPACE
    }

    event_submap() {
      : # SUBMAPNAME
    }
  '';
  hyprlandHandleEvents = pkgs.writeShellScript "hyprlandHandleEvents" ''
    ${pkgs.socat}/bin/socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock \
      EXEC:"${inputs.hyprland-contrib.packages.${pkgs.system}.shellevents}/bin/shellevents ${hyprlandEventHandlers}",nofork
  '';
in
with config.stylix.base16Scheme;
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
      hyprbars
  #      hyprtrails
      csgo-vulkan-fix
    ];
    package = hyprland;
    settings = {
      bind = (
        # Workspace keybind
        # $mod + {1..10} to workspace {1..10}
        # $mod + shift + {1..10} to move to workspace {1..10}
        builtins.concatLists (builtins.genList (x:
          let
            ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in [
            "SUPER, ${ws}, workspace, ${toString (x + 1)}"
            "SUPER SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]) 10));
    };
    extraConfig = ''
        $mod = SUPER
        plugin {
            hyprbars {
                bar_color = rgb(${base00})
                col.text = rgb(${base0D})
                bar_part_of_window = true
                bar_height = 20
                bar_text_font = monospace
                bar_text_size = 8
                bar_text_align = left
            }
        }
        input {
            kb_layout = pt,jp
            kb_variant = anthy
            kb_options = grp:win_space_toggle
            touchpad {
                natural_scroll = yes
                disable_while_typing = false
            }
        }
        decoration {
            rounding = 10
            blur {
                enabled = true
                size = 5
                passes = 2
                vibrancy = 0.5
            }
        }
        gestures {
            workspace_swipe = yes
        }
        windowrule=tile,title:^(Minecraft)(.*)$
        exec=${hyprlandHandleEvents}
        binde=, XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer --decrease 5
        binde=, XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer --increase 5
        binde=, XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s +5%
        binde=, XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 5%-
        bind=$mod, S, exec, ${pkgs.eww-wayland}/bin/eww open shutdown
        bind=$mod, S, submap, shutdown-menu
        bind=, XF86Sleep, exec, ${pkgs.systemd}/bin/systemctl suspend
        bind=$mod, S, exec, ${hyprland}/bin/hyprctl keyword bind ", Escape, exec, eww close shutdown"        bind=, XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t
        bind=CTRL ALT, left, workspace, e-1
        bind=CTRL ALT, right, workspace, e+1
        bind=CTRL ALT SHIFT, left, movetoworkspace, e-1
        bind=CTRL ALT SHIFT, right, movetoworkspace, e+1
        bind=,Print,exec,${pkgs.grim}/bin/grim -c -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f -
        bind=$mod, D, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun -show-icons
        bind=$mod, T, exec, ${pkgs.alacritty}/bin/alacritty
        bind=$mod, F, fullscreen
        bind=$mod, R, submap, rearrange
        # Close app
        bind=$mod, C, killactive

        # Move focus keybinds
        bind=$mod, left, movefocus, l
        bind=$mod, right, movefocus, r
        bind=$mod, up, movefocus, u
        bind=$mod, down, movefocus, d

        bind=$mod, U, focusurgentorlast
        # Switch to mouse mode
        bind=$mod, M, submap, mouse
        
        # Mouse bindings
        submap=mouse
            bindm=$mod,mouse:272,movewindow
            bindm=$mod,mouse:273,resizewindow
            bind=,Escape,submap,reset
        
        # Exit shutdown menu bind
        submap=shutdown-menu
            bind=, Escape, exec, ${pkgs.eww-wayland}/bin/eww close shutdown
            bind=, Escape,submap,reset

        # Rearrange mode keybinds
        submap=rearrange
            $rearrangeMod=SHIFT
            bind=, a, movefocus, l
            bind=, d, movefocus, r
            bind=, w, movefocus, u
            bind=, s, movefocus, d

            binde=, right, resizeactive, -10 0
            binde=, left, resizeactive, 10 0
            binde=, down, resizeactive, 0 -10
            binde=, up, resizeactive, 0 10
        
            bind=, Tab, cyclenext
            bind=$rearrangeMod, Tab, swapnext
 	      
            bind=$rearrangeMod, right,movewindow, r
            bind=$rearrangeMod, left, movewindow, l
            bind=$rearrangeMod, down, movewindow, d
            bind=$rearrangeMod, up,   movewindow, u
            bind=, f,      togglefloating
            bind=, c,      centerwindow
            # Exit rearrange mode
            bind=, Escape, submap         , reset
        submap=reset
        
    '';
  };
}
