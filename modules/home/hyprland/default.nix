{
  pkgs,
  config,
  inputs,
  ...
}: let
  hyprland = pkgs.hyprland;
  hyprlandEventHandlers = pkgs.writeShellScript "hyprlandEventHandlers" ''
    update_active_workspace() {
      ${
      if config.programs.eww.enable
      then "${config.programs.eww.package}/bin/eww update currentworkspace=$WORKSPACENAME"
      else ":"
    }
    }
    event_workspace() {
      update_active_workspace
    }

    event_focusedmon() {
      update_active_workspace
      # MONNAME WORKSPACENAME
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
      # SUBMAPNAME
      ${
      if config.programs.eww.enable
      then "${config.programs.eww.package}/bin/eww update submap=$SUBMAPNAME"
      else ":"
    }
    }
  '';
  hyprlandHandleEvents = pkgs.writeShellScript "hyprlandHandleEvents" ''
    ${pkgs.socat}/bin/socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock \
      EXEC:"${inputs.hyprland-contrib.packages.${pkgs.system}.shellevents}/bin/shellevents ${hyprlandEventHandlers}",nofork
  '';
in
  with config.stylix.base16Scheme; {
    wayland.windowManager.hyprland = {
      package = hyprland;
      settings = {
        bind = (
          # Workspace keybind
          # $mod + {1..10} to workspace {1..10}
          # $mod + shift + {1..10} to move to workspace {1..10}
          builtins.concatLists (builtins.genList (x: let
              ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
            in [
              "SUPER, ${ws}, workspace, ${toString (x + 1)}"
              "SUPER SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ])
            10)
        );
      };
      extraConfig = ''
        $mod = SUPER
        plugin {
            hyprbars {
                bar_color = rgb(${base00})
                col.text = rgb(${base05})
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
                passes = 1
                vibrancy = 0.5
            }
        }
        gestures {
            workspace_swipe = yes
        }
        windowrulev2=opacity ${builtins.toString config.stylix.opacity.applications},class:(vesktop|thunar|firefox|Spotify|Code)$
        windowrulev2=opaque,title:(.*)( - YouTube — Mozilla Firefox)$
        layerrule=blur,(bar)
        ${
          if config.programs.eww.enable
          then "exec-once=${config.programs.eww.package}/bin/eww open bar"
          else ""
        }
        ${
          if (config.programs.vesktop.vencord.settings.plugins."WebRichPresence (arRPC)".enabled or false)
          then "exec-once=${pkgs.arrpc}/bin/arrpc"
          else ""
        }
        exec-once=${hyprlandHandleEvents}
        exec-once=${pkgs.dex}/bin/dex -a
        binde=, XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer --decrease 5
        binde=, XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer --increase 5
        binde=, XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s +5%
        binde=, XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 5%-
        ${
          if config.programs.eww.enable
          then "bind=$mod, S, exec, ${config.programs.eww.package}/bin/eww open shutdown"
          else ""
        }
        ${
          if config.programs.eww.enable
          then "bind=$mod, S, submap, shutdown-menu"
          else ""
        }
        bind=, XF86Sleep, exec, ${pkgs.systemd}/bin/systemctl suspend
        bind=, XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t
        bind=CTRL ALT, left, workspace, e-1
        bind=CTRL ALT, right, workspace, e+1
        bind=CTRL ALT SHIFT, left, movetoworkspace, e-1
        bind=CTRL ALT SHIFT, right, movetoworkspace, e+1
        bind=,Print,exec,${pkgs.grim}/bin/grim -c -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f -
        ${
          if config.programs.rofi.enable
          then "bind=$mod, D, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun -show-icons"
          else ""
        }
        ${
          if config.programs.kitty.enable
          then "bind=$mod, T, exec, ${pkgs.kitty}/bin/kitty"
          else ""
        }
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
            bindm=,mouse:272,movewindow
            bindm=,mouse:273,resizewindow
            bind=,Escape,submap,reset
        ${
          if config.programs.eww.enable
          then "submap=shutdown-menu"
          else ""
        }
        ${
          if config.programs.eww.enable
          then "    bind=, Escape, exec, ${config.programs.eww.package}/bin/eww close shutdown"
          else ""
        }
        ${
          if config.programs.eww.enable
          then "    bind=, Escape,submap,reset"
          else ""
        }

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
