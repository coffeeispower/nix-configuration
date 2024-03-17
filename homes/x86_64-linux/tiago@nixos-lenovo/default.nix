{
  config,
  pkgs,
  lib,
  ...
}: {
  home.stateVersion = "23.11";
  programs.git = {
    enable = true;
    userName = "Tiago Dinis";
    userEmail = "tiagodinis33@proton.me";
  };

  services.gpg-agent.enable = true;
  services.fcitx5.enable = true;
  services.dunst.enable = true;

  gtk.enable = true;

  programs.direnv.enable = true;
  programs.eww.enable = true;
  programs.feh.enable = true;
  programs.feh.mimeApps.defaultAssociation.enable = true;
  programs.firefox.enable = true;
  programs.gh.enable = true;
  programs.helix.enable = true;
  wayland.windowManager.hyprland.enable = true;
  programs.hyprpaper.enable = true;
  programs.kitty.enable = true;
  programs.lazygit.enable = true;
  programs.networkmanager-dmenu.enable = true;
  programs.nushell.enable = true;
  programs.rofi.enable = true;
  programs.spicetify.enable = true;
  programs.thunar.enable = true;
  programs.vscode.enable = true;
  programs.zellij.enable = true;
  programs.zoxide.enable = true;
  programs.vesktop.enable = true;
  programs.vesktop.stylixIntegration.enable = true;
  programs.vesktop.vencord.settings = {
    plugins = {
      BadgeAPI = {
        enabled = true;
      };
      CommandsAPI = {
        enabled = true;
      };
      ContextMenuAPI = {
        enabled = true;
      };
      NoticesAPI = {
        enabled = true;
      };
      NoTrack = {
        enabled = true;
      };
      Settings = {
        enabled = true;
        settingsLocation = "aboveActivity";
      };
      SupportHelper = {
        enabled = true;
      };
      AlwaysAnimate = {
        enabled = true;
      };
      "WebRichPresence (arRPC)" = {
        enabled = true;
      };
      CrashHandler = {
        enabled = true;
      };
      Experiments = {
        enabled = true;
      };
      ImageZoom = {
        enabled = true;
      };
      SpotifyControls = {
        enabled = true;
      };
      VoiceMessages = {
        enabled = true;
      };
      WebContextMenus = {
        enabled = true;
        addBack = true;
      };
      WebKeybinds = {
        enabled = true;
      };
    };
  };

  xdg.mimeApps = {
    enable = true;
    associations.added."application/pdf" = ["org.gnome.Evince.desktop"];
    defaultApplications."application/pdf" = ["org.gnome.Evince.desktop"];
  };

  programs.pyprland = {
    enable = true;
    config = {
      pyprland.plugins = ["scratchpads"];
      scratchpads = {
        pavucontrol = {
          command = "${pkgs.pavucontrol}/bin/pavucontrol";
          margin = 50;
          unfocus = "hide";
          animation = "fromTop";
          lazy = true;
        };

        kitty = {
          command = "${pkgs.kitty}/bin/kitty --class scratchpad";
          margin = 50;
          unfocus = "hide";
          animation = "fromTop";
          lazy = true;
        };
      };
    };
  };
}
