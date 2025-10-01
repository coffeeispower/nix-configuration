{
  pkgs,
  inputs,
  system,
  ...
}: let
  unstable = import inputs.nixpkgs-unstable {inherit system;};
in {

  home.stateVersion = "24.05";
  programs.zed-editor.enable = true;
  programs.git = {
    enable = true;
    userName = "Tiago Dinis";
    userEmail = "tiagodinis33@proton.me";
  };
  services.gpg-agent.enable = true;
  services.fcitx5.enable = false;
  services.dunst.enable = false;
  services.hypridle.enable = false;

  stylix.targets.kde.enable = true;

  gtk.enable = true;
  home.packages = with pkgs; [
    unstable.zed-editor
    stremio
    yt-dlp
    blender
    wl-clipboard
    showmethekey
    bun
  ];
  programs.hyprlock.enable = true;
  programs.direnv.enable = true;
  programs.feh.enable = true;
  programs.feh.mimeApps.defaultAssociation.enable = true;
  programs.gh.enable = true;
  programs.helix.enable = true;
  wayland.windowManager.hyprland.enable = false;
  programs.kitty.enable = true;
  programs.lazygit.enable = true;
  programs.networkmanager-dmenu.enable = true;
  programs.nushell.enable = true;
  programs.rofi.enable = true;
  programs.spicetify.enable = true;
  programs.nautilus.enable = false;
  programs.vscode.enable = false;
  programs.zellij.enable = true;
  programs.zoxide.enable = true;
  programs.fastfetch.enable = true;
  programs.custom.vesktop.enable = true;
  stylix.targets.vesktop.enable = false;
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

  services.syncthing.enable = true;
  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
    };
  };
}
