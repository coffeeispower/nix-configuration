{
  lib,
  config,
  pkgs,
  ...
}:
with lib; {
  options.programs.thunar = {
    enable = mkEnableOption "thunar";

    defaultFileManager = mkOption {
      type = types.bool;
      default = true;
      description = "Open folders in thunar by default";
    };
  };

  config = {
    home.packages = [
      (mkIf config.programs.thunar.enable pkgs.xfce.thunar)
      (mkIf config.programs.thunar.enable pkgs.xfce.thunar-volman)
      (mkIf config.programs.thunar.enable pkgs.xfce.thunar-archive-plugin)
    ];
    xdg.mimeApps = rec {
      enable = config.programs.thunar.enable && config.programs.thunar.defaultFileManager;
      associations.added = optionalAttrs enable {"inode/directory" = ["thunar.desktop"];};
      defaultApplications = optionalAttrs enable {"inode/directory" = ["thunar.desktop"];};
    };
  };
}
