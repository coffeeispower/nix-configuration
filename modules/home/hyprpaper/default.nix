{
  pkgs,
  config,
  lib,
  ...
}:
with lib; {
  options.programs.hyprpaper = {
    enable = mkEnableOption "hyprpaper";
    package = mkOption {
      type = types.package;
      default = pkgs.hyprpaper;
      defaultText = literalExpression "pkgs.hyprpaper";
      description = "The package to use for hyprpaper.";
    };
    enableHyprlandIntegration = mkOption {
      type = types.bool;
      default = config.wayland.windowManager.hyprland.enable;
      defaultText = "`true` if hyprland is enabled, `false` otherwise.";
      description = "Auto start hyprpaper when hyprland starts up.";
    };
    wallpaper = mkOption {
      type = types.path;
      default = config.stylix.image;
      defaultText = literalExpression "config.stylix.image";
      description = "The wallpaper to set";
    };
  };
  config = let
    hyprpaper = config.programs.hyprpaper;
  in {
    xdg.configFile."hypr/hyprpaper.conf".text = mkIf hyprpaper.enable ''
      preload=${hyprpaper.wallpaper}
      wallpaper=eDP-1,${hyprpaper.wallpaper}
      wallpaper=DP-1,${hyprpaper.wallpaper}
    '';
    wayland.windowManager.hyprland.settings.exec = [
      (mkIf (hyprpaper.enableHyprlandIntegration && config.wayland.windowManager.hyprland.enable) "${hyprpaper.package}/bin/hyprpaper")
    ];
  };
}
