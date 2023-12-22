{ config, pkgs, lib, inputs, system, ... }:

{
  imports = [ inputs.nix-colors.homeManagerModules.default ];
  # -------------------------- Nix Colors --------------------------
  colorScheme = inputs.nix-colors.colorSchemes.dracula;
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
  };

  # --------------------------- Hyprland ---------------------------
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      exec = [ "eww --restart open bar" ];
      exec-once = [ "hypr" ];
      # Set mod key to super
      "$mod" = "SUPER";
      bindm = [ "$mod,mouse:272,movewindow" "$mod,mouse:273,resizewindow" ];
      bindr = [
        "$mod, D, exec, pkill rofi || ${pkgs.rofi-wayland}/bin/rofi -show drun -show-icons"
      ];
      input = {
        # Set keyboard layout to portuguese
        kb_layout = "pt";
        # Enable touchpad natural scroll
        touchpad.natural_scroll = "yes";
      };
      # Enable workspace swipe
      gestures.workspace_swipe = "yes";
      binde = [
        ", XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer --decrease 5"
        ", XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer --increase 5"
      ];
      bind = [
        ", Print, exec, ${pkgs.grimblast}/bin/grimblast copy area"
        "$mod, left, workspace, e-1"
        "$mod, right, workspace, e+1"

        "$mod, R, exec, eww --restart open bar"
        "$mod SHIFT, left, movetoworkspace, e-1"
        "$mod SHIFT, right, movetoworkspace, e+1"
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
          name = "yuck";
          publisher = "eww-yuck";
          version = "0.0.3";
          sha256 = "sha256-DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
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
  home.packages = with pkgs; [ nixfmt pamixer libnotify ];
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
    shellAliases = {
      lg = "lazygit";
    };
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
      palette = {
        base00 = "#${config.colorScheme.colors.base00}"; # Default Background
        base01 =
          "#${config.colorScheme.colors.base01}"; # Lighter Background (Used for status bars, line number and folding marks)
        base02 = "#${config.colorScheme.colors.base02}"; # Selection Background
        base03 =
          "#${config.colorScheme.colors.base03}"; # Comments, Invisibles, Line Highlighting
        base04 =
          "#${config.colorScheme.colors.base04}"; # Dark Foreground (Used for status bars)
        base05 =
          "#${config.colorScheme.colors.base05}"; # Default Foreground, Caret, Delimiters, Operators
        base06 =
          "#${config.colorScheme.colors.base06}"; # Light Foreground (Not often used)
        base07 =
          "#${config.colorScheme.colors.base07}"; # Light Background (Not often used)
        base08 =
          "#${config.colorScheme.colors.base08}"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
        base09 =
          "#${config.colorScheme.colors.base09}"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
        base0A =
          "#${config.colorScheme.colors.base0A}"; # Classes, Markup Bold, Search Text Background
        base0B =
          "#${config.colorScheme.colors.base0B}"; # Strings, Inherited Class, Markup Code, Diff Inserted
        base0C =
          "#${config.colorScheme.colors.base0C}"; # Support, Regular Expressions, Escape Characters, Markup Quotes
        base0D =
          "#${config.colorScheme.colors.base0D}"; # Functions, Methods, Attribute IDs, Headings
        base0E =
          "#${config.colorScheme.colors.base0E}"; # Keywords, Storage, Selector, Markup Italic, Diff Changed
        base0F =
          "#${config.colorScheme.colors.base0F}"; # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
      };
    };
  };
  # ---------------------------------- Eww ------------------------------------
  programs.eww.enable = true;
  programs.eww.package = pkgs.eww-wayland;
  programs.eww.configDir = (import ./eww-config.nix) {
    inherit pkgs lib;
    widgets-bg = "#${config.colorScheme.colors.base01}";
    widgets-fg = "#${config.colorScheme.colors.base06}";
    widgets-fg-dark = "#${config.colorScheme.colors.base04}";
    widgets-track = "#${config.colorScheme.colors.base00}";
    low-battery-color = "#${config.colorScheme.colors.base08}";
    charging-battery-color = "#${config.colorScheme.colors.base0A}";
  };
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
}
