{
  pkgs,
  lib,
  config,
  ...
}: let
  tomlFormat = pkgs.formats.toml {};
in
  with lib; {
    options = {
      programs.pyprland = {
        enable = mkEnableOption "pyprland";
        package = mkOption {
          type = types.package;
          default = pkgs.pyprland;
          defaultText = literalExpression "pkgs.pyprland";
          description = "The package to use for pyprland.";
        };
        config = mkOption {
          type = tomlFormat.type;
          description = "Extra configuration options for pyprland";
          default = {};
          defaultText = "{ }";
        };
      };
    };
    config = {
      home.packages = [
        (mkIf config.programs.pyprland.enable config.programs.pyprland.package)
      ];
      xdg.configFile."hypr/pyprland.toml" = {
        enable = config.programs.pyprland.enable;
        source = tomlFormat.generate "pyprland.toml" config.programs.pyprland.config;
      };
      wayland.windowManager.hyprland.settings.exec-once = [
        "${config.programs.pyprland.package}/bin/pypr"
      ];
    };
  }
