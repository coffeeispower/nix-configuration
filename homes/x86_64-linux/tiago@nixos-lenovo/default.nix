{ config, pkgs, lib, inputs, system, ... }:

{
  imports = [ inputs.nix-colors.homeManagerModules.default ];
  home.file.".config/wallpapers/".source = ./wallpapers;
  home.file.".config/fcitx5/".source = ./fcitx5;
  # -------------------------- Nix Colors --------------------------
  colorScheme = inputs.nix-colors.colorSchemes.material-darker;
  # ---------------------------- Dunst -----------------------------
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        frame_color = "#${config.colorScheme.colors.base0E}";
        font = "monospace";
      };
      urgency_normal = {
        background = "#${config.colorScheme.colors.base01}";
        foreground = "#${config.colorScheme.colors.base04}";
        timeout = 10;
      };
    };
  };
  # ----------------------------- Rofi -----------------------------
  programs.rofi = {
    enable = true;
    cycle = true;
    # Install the wayland variant of rofi
    package = pkgs.rofi-wayland;
    # Set terminal to alacritty
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = let
      # Use `mkLiteral` for string-like values that should show without
      # quotes, e.g.:
      # {
      #   foo = "abc"; => foo: "abc";
      #   bar = mkLiteral "abc"; => bar: abc;
      # };
      inherit (config.lib.formats.rasi) mkLiteral;
      inherit (config.colorScheme.colors)
        base08 base0D base06 base01 base05 base00;
    in {

      "*" = {
        "red" = mkLiteral "#${base08}";
        "blue" = mkLiteral "#${base0D}";
        "lightfg" = mkLiteral "#${base06}";
        "lightbg" = mkLiteral "#${base01}";
        "foreground" = mkLiteral "#${base05}";
        "background" = mkLiteral "#${base00}";
        "background-color" = mkLiteral "#${base00}";
        "separatorcolor" = mkLiteral "@foreground";
        "border-color" = mkLiteral "@foreground";
        "selected-normal-foreground" = mkLiteral "@lightbg";
        "selected-normal-background" = mkLiteral "@lightfg";
        "selected-active-foreground" = mkLiteral "@background";
        "selected-active-background" = mkLiteral "@blue";
        "selected-urgent-foreground" = mkLiteral "@background";
        "selected-urgent-background" = mkLiteral "@red";
        "normal-foreground" = mkLiteral "@foreground";
        "normal-background" = mkLiteral "@background";
        "active-foreground" = mkLiteral "@blue";
        "active-background" = mkLiteral "@background";
        "urgent-foreground" = mkLiteral "@red";
        "urgent-background" = mkLiteral "@background";
        "alternate-normal-foreground" = mkLiteral "@foreground";
        "alternate-normal-background" = mkLiteral "@lightbg";
        "alternate-active-foreground" = mkLiteral "@blue";
        "alternate-active-background" = mkLiteral "@lightbg";
        "alternate-urgent-foreground" = mkLiteral "@red";
        "alternate-urgent-background" = mkLiteral "@lightbg";
        "spacing" = 2;
      };
      "window" = {
        "background-color" = mkLiteral "@background";
        "border" = 1;
        "padding" = 5;
      };
      "mainbox" = {
        "border" = 0;
        "padding" = 0;
      };
      "message" = {
        "border" = mkLiteral "1px dash 0px 0px";
        "border-color" = mkLiteral "@separatorcolor";
        "padding" = mkLiteral "1px";
      };
      "textbox" = { "text-color" = mkLiteral "@foreground"; };
      "listview" = {
        "fixed-height" = 0;
        "border" = mkLiteral "2px dash 0px 0px";
        "border-color" = mkLiteral "@separatorcolor";
        "spacing" = mkLiteral "2px";
        "scrollbar" = true;
        "padding" = mkLiteral "2px 0px 0px";
      };
      "element-text, element-icon" = {
        "background-color" = mkLiteral "inherit";
        "text-color" = mkLiteral "inherit";
      };
      "element" = {
        "border" = 0;
        "padding" = mkLiteral "1px";
      };
      "element normal.normal" = {
        "background-color" = mkLiteral "@normal-background";
        "text-color" = mkLiteral "@normal-foreground";
      };
      "element normal.urgent" = {
        "background-color" = mkLiteral "@urgent-background";
        "text-color" = mkLiteral "@urgent-foreground";
      };
      "element normal.active" = {
        "background-color" = mkLiteral "@active-background";
        "text-color" = mkLiteral "@active-foreground";
      };
      "element selected.normal" = {
        "background-color" = mkLiteral "@selected-normal-background";
        "text-color" = mkLiteral "@selected-normal-foreground";
      };
      "element selected.urgent" = {
        "background-color" = mkLiteral "@selected-urgent-background";
        "text-color" = mkLiteral "@selected-urgent-foreground";
      };
      "element selected.active" = {
        "background-color" = mkLiteral "@selected-active-background";
        "text-color" = mkLiteral "@selected-active-foreground";
      };
      "element alternate.normal" = {
        "background-color" = mkLiteral "@alternate-normal-background";
        "text-color" = mkLiteral "@alternate-normal-foreground";
      };
      "element alternate.urgent" = {
        "background-color" = mkLiteral "@alternate-urgent-background";
        "text-color" = mkLiteral "@alternate-urgent-foreground";
      };
      "element alternate.active" = {
        "background-color" = mkLiteral "@alternate-active-background";
        "text-color" = mkLiteral "@alternate-active-foreground";
      };
      "scrollbar" = {
        "width" = mkLiteral "4px";
        "border" = 0;
        "handle-color" = mkLiteral "@normal-foreground";
        "handle-width" = mkLiteral "8px";
        "padding" = 0;
      };
      "sidebar" = {
        "border" = mkLiteral "2px dash 0px 0px";
        "border-color" = mkLiteral "@separatorcolor";
      };
      "button" = {
        "spacing" = 0;
        "text-color" = mkLiteral "@normal-foreground";
      };
      "button selected" = {
        "background-color" = mkLiteral "@selected-normal-background";
        "text-color" = mkLiteral "@selected-normal-foreground";
      };
      "inputbar" = {
        "spacing" = mkLiteral "0px";
        "text-color" = mkLiteral "@normal-foreground";
        "padding" = mkLiteral "1px";
        "children" = map mkLiteral [
          "prompt"
          "textbox-prompt-colon"
          "entry"
          "case-indicator"
        ];
      };
      "case-indicator" = {
        "spacing" = 0;
        "text-color" = mkLiteral "@normal-foreground";
      };
      "entry" = {
        "spacing" = 0;
        "text-color" = mkLiteral "@normal-foreground";
      };
      "prompt" = {
        "spacing" = 0;
        "text-color" = mkLiteral "@normal-foreground";
      };
      "textbox-prompt-colon" = {
        "expand" = false;
        "str" = ":";
        "margin" = mkLiteral "0px 0.3000em 0.0000em 0.0000em";
        "text-color" = mkLiteral "inherit";
      };
    };
  };

  # --------------------------- Hyprland ---------------------------
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      general = let inherit (config.colorScheme.colors) base00 base01 base0A;
      in {
        "col.active_border" = "rgba(${base01}ff) rgba(${base0A}ff) 45deg";
        "col.inactive_border" = "rgba(${base00}ff)";
        "border_size" = 2;
      };
      "device:at-translated-set-2-keyboard" = {
        kb_layout = "pt,jp";
        kb_variant = "anthy";
        kb_options = "grp:win_space_toggle";
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
      exec = [
        # Start Eww on Startup, killing any previous instances to avoid 2 bars on top
        (pkgs.writeShellScript "reset-eww" ''
          pkill eww
          eww open bar
        '')

        # Start Hyprpaper with the beautiful hackerman wallpaper :sunglasses:
        "${pkgs.hyprpaper}/bin/hyprpaper -c ${
          pkgs.writeText "hyprpaper.conf" ''
            preload=/home/tiago/.config/wallpapers/hackerman.jpg
            wallpaper=eDP-1,/home/tiago/.config/wallpapers/hackerman.jpg
          ''
        }"
      ];
      exec-once = [
        "${pkgs.fcitx5}/bin/fcitx5 -d"
      ];
      # Set mod key to super
      "$mod" = "SUPER";

      # Move apps with the mouse
      bindm = [ "$mod,mouse:272,movewindow" "$mod,mouse:273,resizewindow" ];

      input = {
        # Enable touchpad natural scroll
        touchpad.natural_scroll = "yes";
      };
      # Enable workspace swipe
      gestures.workspace_swipe = "yes";
      binde = [
        # Volume Up and Down keybinds
        ", XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer --decrease 5"
        ", XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer --increase 5"
      ];
      bind = [
        # Screenshot keybind
        ", Print, exec, ${pkgs.grimblast}/bin/grimblast copy area"
        # Vine boom sound effect keybind
        "$mod, B, exec, ${pkgs.sox}/bin/play ${./vineboom.mp3}"
        "$mod, B, exec, ${pkgs.libnotify}/bin/notify-send WTFFF"
        # Vsauce music keybind
        "$mod, V, exec, ${pkgs.sox}/bin/play ${./vsauce.mp3}"
        ''$mod, V, exec, ${pkgs.libnotify}/bin/notify-send "Or is it?"''
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

  # ------------------------------- Git Config ----------------------------------
  programs.git = {
    enable = true;
    userName = "Tiago Dinis";
    userEmail = "tiagodinis33@proton.me";
  };

  # ----------------------------- VS Code config --------------------------------
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions;
      [ jnoortheen.nix-ide ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        
        {
          name = "svelte-vscode";
          publisher = "svelte";
          version = "108.1.0";
          sha256 = "sha256-LCY8M77vfvzcNGOHWrDcuRkhxH1/LeUkI5r37sDuCuI=";
        }        {
          name = "yuck";
          publisher = "eww-yuck";
          version = "0.0.3";
          sha256 = "sha256-DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
        }
        {
          name = "vsliveshare";
          publisher = "MS-vsliveshare";
          version = "1.0.5900";
          sha256 = "sha256-syVW/aS2ppJjg4OZaenzGM3lczt+sLy7prwsYFTDl9s=";
        }
        {
          name = "vscode-nushell-lang";
          publisher = "thenuprojectcontributors";
          version = "1.7.1";
          sha256 = "sha256-JlkZ8rarwTdQpiR76RR1s4XgH+lOIXfa0rAwLxvoYUc=";
        }
        {
          name = "intellij-idea-keybindings";
          publisher = "k--kato";
          version = "1.5.12";
          sha256 = "sha256-khXO8zLwQcdqiJxFlgLQSQbVz2fNxFY6vGTuD1DBjlc=";
        }
      ];
  };
  # --------------------------------- Lazygit -----------------------------------
  programs.lazygit = { enable = true; };

  # -------------------------------- Alacritty ----------------------------------
  programs.alacritty = {
    enable = true;
    settings = {
      colors = with config.colorScheme.colors; {
        bright = {
          black = "0x${base00}";
          blue = "0x${base0D}";
          cyan = "0x${base0C}";
          green = "0x${base0B}";
          magenta = "0x${base0E}";
          red = "0x${base08}";
          white = "0x${base06}";
          yellow = "0x${base09}";
        };
        cursor = {
          cursor = "0x${base06}";
          text = "0x${base06}";
        };
        normal = {
          black = "0x${base00}";
          blue = "0x${base0D}";
          cyan = "0x${base0C}";
          green = "0x${base0B}";
          magenta = "0x${base0E}";
          red = "0x${base08}";
          white = "0x${base06}";
          yellow = "0x${base0A}";
        };
        primary = {
          background = "0x${base00}";
          foreground = "0x${base06}";
        };
      };
    };
  };

  # ------------------- Setup basic home manager settings -----------------------
  home.username = "tiago";
  home.homeDirectory = "/home/tiago";
  home.stateVersion = "23.11";
  home.packages = with pkgs; [
    lutris wine
    nixfmt
    pamixer
    libnotify
    spotify
    discord
    cli-visualizer
    pavucontrol
    neofetch
    feh
    vlc
  ];
  # --------------------------- Allow unfree packages ---------------------------
  nixpkgs.config.allowUnfree = true;
  # -------------------------------- GTK Theme ----------------------------------
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
  # -------------------------------- Nushell ----------------------------------
  programs.nushell = {
    enable = true;
    shellAliases = { lg = "lazygit"; };
  };
  # --------------------------------- Helix -----------------------------------
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings.theme = "base16nix";
    themes.base16nix = {
      "attributes" = "base09";
      "comment" = {
        fg = "base03";
        modifiers = [ "italic" ];
      };
      "constant" = "base09";
      "constant.character.escape" = "base0C";
      "constant.numeric" = "base09";
      "constructor" = "base0D";
      "debug" = "base03";
      "diagnostic" = { modifiers = [ "underlined" ]; };
      "diff.delta" = "base09";
      "diff.minus" = "base08";
      "diff.plus" = "base0B";
      "error" = "base08";
      "function" = "base0D";
      "hint" = "base03";
      "info" = "base0D";
      "keyword" = "base0E";
      "label" = "base0E";
      "namespace" = "base0E";
      "operator" = "base05";
      "special" = "base0D";
      "string" = "base0B";
      "type" = "base0A";
      "variable" = "base08";
      "variable.other.member" = "base0B";
      "warning" = "base09";

      "markup.bold" = {
        fg = "base0A";
        modifiers = [ "bold" ];
      };
      "markup.heading" = "base0D";
      "markup.italic" = {
        fg = "base0E";
        modifiers = [ "italic" ];
      };
      "markup.link.text" = "base08";
      "markup.link.url" = {
        fg = "base09";
        modifiers = [ "underlined" ];
      };
      "markup.list" = "base08";
      "markup.quote" = "base0C";
      "markup.raw" = "base0B";
      "markup.strikethrough" = { modifiers = [ "crossed_out" ]; };

      "diagnostic.hint" = { underline = { style = "curl"; }; };
      "diagnostic.info" = { underline = { style = "curl"; }; };
      "diagnostic.warning" = { underline = { style = "curl"; }; };
      "diagnostic.error" = { underline = { style = "curl"; }; };

      "ui.background" = { bg = "base00"; };
      "ui.bufferline.active" = {
        fg = "base00";
        bg = "base03";
        modifiers = [ "bold" ];
      };
      "ui.bufferline" = {
        fg = "base04";
        bg = "base00";
      };
      "ui.cursor" = {
        fg = "base0A";
        modifiers = [ "reversed" ];
      };
      "ui.cursor.insert" = {
        fg = "base0A";
        modifiers = [ "revsered" ];
      };
      "ui.cursorline.primary" = {
        fg = "base05";
        bg = "base01";
      };
      "ui.cursor.match" = {
        fg = "base0A";
        modifiers = [ "reversed" ];
      };
      "ui.cursor.select" = {
        fg = "base0A";
        modifiers = [ "reversed" ];
      };
      "ui.gutter" = { bg = "base00"; };
      "ui.help" = {
        fg = "base06";
        bg = "base01";
      };
      "ui.linenr" = {
        fg = "base03";
        bg = "base00";
      };
      "ui.linenr.selected" = {
        fg = "base04";
        bg = "base01";
        modifiers = [ "bold" ];
      };
      "ui.menu" = {
        fg = "base05";
        bg = "base01";
      };
      "ui.menu.scroll" = {
        fg = "base03";
        bg = "base01";
      };
      "ui.menu.selected" = {
        fg = "base01";
        bg = "base04";
      };
      "ui.popup" = { bg = "base01"; };
      "ui.selection" = { bg = "base02"; };
      "ui.selection.primary" = { bg = "base02"; };
      "ui.statusline" = {
        fg = "base04";
        bg = "base01";
      };
      "ui.statusline.inactive" = {
        bg = "base01";
        fg = "base03";
      };
      "ui.statusline.insert" = {
        fg = "base00";
        bg = "base0B";
      };
      "ui.statusline.normal" = {
        fg = "base00";
        bg = "base03";
      };
      "ui.statusline.select" = {
        fg = "base00";
        bg = "base0F";
      };
      "ui.text" = "base05";
      "ui.text.focus" = "base05";
      "ui.virtual.indent-guide" = { fg = "base03"; };
      "ui.virtual.inlay-hint" = { fg = "base01"; };
      "ui.virtual.ruler" = { bg = "base01"; };
      "ui.window" = { bg = "base01"; };
      
      palette = lib.attrsets.mapAttrs (name: value:  "#" + value) config.colorScheme.colors;
    };
  };
  # ---------------------------------- Eww ------------------------------------
  programs.eww.enable = true;
  programs.eww.package = pkgs.eww-wayland;
  programs.eww.configDir = (import ./eww-config.nix) (let
    inherit (config.colorScheme.colors)
      base01 base06 base04 base00 base08 base0A;
  in {
    inherit pkgs lib;
    widgets-bg = "#${base01}";
    widgets-fg = "#${base06}";
    widgets-fg-dark = "#${base04}";
    widgets-track = "#${base00}";
    low-battery-color = "#${base08}";
    charging-battery-color = "#${base0A}";
  });
  # -------------------------------- Firefox ----------------------------------
  programs.firefox = {
    enable = true;
    profiles.tiago = {
      extensions = let firefox-ext = inputs.firefox-addons.packages.${system};
      in [
        firefox-ext.ublock-origin
        firefox-ext.darkreader
        firefox-ext."10ten-ja-reader"
        firefox-ext.proton-pass
      ];
    };
  };

  # -------------------------------- Github CLI -------------------------------
  programs.gh = { enable = true; };
  # -------------------------------- Enable DirEnv -------------------------------
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  xdg.mimeApps = let
    associations = {
      "inode/directory" = ["thunar.desktop"];
      "image/png" = ["feh.desktop"];
      "image/jpeg" = ["feh.desktop"];
      "image/webp" = ["feh.desktop"];
      "image/gif" = ["feh.desktop"];
      "image/bmp" = ["feh.desktop"];
      "image/svg+xml" = ["feh.desktop"];
      "image/tiff" = ["feh.desktop"];
      "image/apng" = ["feh.desktop"];
    };
  in
  {
    enable = true;
    associations.added = associations;
    defaultApplications = associations;
  };
}
