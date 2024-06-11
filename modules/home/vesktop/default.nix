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
  mergedVencordSettings = recursiveUpdate (recursiveUpdate
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
    }
    (optionalAttrs config.programs.vesktop.stylixIntegration.enable {
      enabledThemes = [
        "Stylix.theme.css"
      ];
    }))
  config.programs.vesktop.vencord.settings;
  # settings.json file
  mergedVesktopSettings = recursiveUpdate (recursiveUpdate
    {
      discordBranch = "stable";
      firstLaunch = false;
      arRPC = "on";
      skippedUpdate = "1.5.0";
      staticTitle = true;
      appBadge = false;
    }
    (optionalAttrs config.programs.vesktop.stylixIntegration.enable {
      splashColor = "#${config.stylix.base16Scheme.base0A}";
      splashBackground = "#${config.stylix.base16Scheme.base00}";
      splashTheming = true;
    }))
  config.programs.vesktop.settings;
in {
  options.programs.vesktop = {
    enable = mkEnableOption "vesktop";
    stylixIntegration.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Generate a theme for vesktop using stylix color scheme";
    };
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
    xdg.configFile."vesktop/themes/Stylix.theme.css" = {
      enable = config.programs.vesktop.stylixIntegration.enable;
      source = with config.stylix.base16Scheme; let
        inherit (inputs.nix-rice.lib) color;
        base09Rgba = color.hexToRgba "#${base09}";
        base0ARgba = color.hexToRgba "#${base0A}";
      in
        lib.my-lib.mustache.template {
          inherit pkgs;
          name = "vesktop-stylix-theme";
          templateFile = ./Stylix.theme.css.mustache;
          variables =
            {
              splitBase09 = "${builtins.toString (builtins.floor base09Rgba.r)}, ${builtins.toString (builtins.floor base09Rgba.g)}, ${builtins.toString (builtins.floor base09Rgba.b)}";
              splitBase0A = "${builtins.toString (builtins.floor base0ARgba.r)}, ${builtins.toString (builtins.floor base0ARgba.g)}, ${builtins.toString (builtins.floor base0ARgba.b)}";
            }
            // config.stylix.base16Scheme;
        };
    };
  };
}
