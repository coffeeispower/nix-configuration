{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
with lib; let
  jsonFormat = pkgs.formats.json {};

  # settings/settings.json file
  mergedVencordSettings = recursiveUpdate 
    {
      notifyAboutUpdates = false;
      autoUpdate = false;
      autoUpdateNotification = false;
      useQuickCss = false;
      themeLinks = [];
      enableReactDevtools = false;
      frameless = false;
      transparent = true;
      winCtrlQ = false;
      macosTranslucency = false;
      disableMinSize = true;
      winNativeTitleBar = false;

      notifications = {
        timeout = 5000;
        position = "bottom-right";
        useNative = "not-focused";
        logLimit = 50;
      };
      enabledThemes = [
        "stylix.theme.css"
      ];
    }
  config.programs.vesktop.vencord.settings;
  # settings.json file
  mergedVesktopSettings = recursiveUpdate {
      discordBranch = "stable";
      firstLaunch = false;
      arRPC = "on";
      skippedUpdate = "1.5.0";
      staticTitle = true;
      appBadge = false;
      splashColor = "#${config.stylix.base16Scheme.base0A}";
      splashBackground = "#${config.stylix.base16Scheme.base00}";
      splashTheming = true;
    }
  config.programs.vesktop.settings;
in {
  options.programs.vesktop = {
    enable = mkEnableOption "vesktop";
    vencord.settings = mkOption {
      type = jsonFormat.type;
      default = {};
      description = "Additional configuration written in $XDG_CONFIG_DIR/vesktop/settings/settings.json";
    };
    settings = mkOption {
      type = jsonFormat.type;
      default = {};
      description = "Additional configuration written in $XDG_CONFIG_DIR/vesktop/settings.json";
    };
  };
  config = {
    home.packages = [(mkIf config.programs.vesktop.enable pkgs.vesktop)];
    home.activation.vencordCP = mkIf config.programs.vesktop.enable (
      inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
        mkdir -p $HOME/.config/vesktop/settings/
        cat ${jsonFormat.generate "vencord-config" mergedVencordSettings} > $HOME/.config/vesktop/settings/settings.json
        cat ${jsonFormat.generate "vesktop-config" mergedVesktopSettings} > $HOME/.config/vesktop/settings.json
      ''
    );
  };
}
