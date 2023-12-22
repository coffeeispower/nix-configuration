{ config, pkgs, lib, inputs, system, ... }:

{
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
      exec = [
        "eww kill"
        "eww open bar"
      ];
      # Set mod key to super
      "$mod" = "SUPER";
      bindm = [
        "$mod,mouse:272,movewindow"
        "$mod,mouse:273,resizewindow"
      ];
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
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
  programs.lazygit.enable = true;

  # -------------------------------- Alacritty ----------------------------------
  programs.alacritty.enable = true;

  # ------------------- Setup basic home manager settings -----------------------
  home.username = "tiago";
  home.homeDirectory = "/home/tiago";
  home.stateVersion = "23.11";
  home.packages = with pkgs; [ nixfmt pamixer ];
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
  programs.nushell.enable = true;
  # --------------------------------- Helix -----------------------------------
  programs.helix.enable = true;
  programs.helix.defaultEditor = true;
  # ---------------------------------- Eww ------------------------------------
  programs.eww.enable = true;
  programs.eww.package = pkgs.eww-wayland;
  programs.eww.configDir = (import ./eww-config.nix) {
    inherit pkgs lib;
    widgets-bg = "#57f287";
    widgets-fg = "#000";
    widgets-fg-light = "#FFF";
    widgets-track = "#4e4e4e";
  };
  # -------------------------------- Firefox ----------------------------------
  programs.firefox = {
  
    enable = true;
    profiles.tiago = {
     extensions = let 
      firefox-ext = inputs.firefox-addons.packages.${system};
     in [
        firefox-ext.ublock-origin
        firefox-ext.darkreader
        firefox-ext."10ten-ja-reader"
      ];
    };
  };
}
