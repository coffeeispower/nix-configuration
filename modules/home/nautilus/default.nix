{
  lib,
  config,
  pkgs,
  ...
}:
with lib; {
  options.programs.nautilus = {
    enable = mkEnableOption "nautilus";

    defaultFileManager = mkOption {
      type = types.bool;
      default = true;
      description = "Open folders in nautilus by default";
    };
  };

  config = let
    cfg = config.programs.nautilus;
  in {
    home.packages = [
      (mkIf cfg.enable pkgs.nautilus)
    ];
    xdg.mimeApps = rec {
      enable = cfg.enable && config.programs.nautilus.defaultFileManager;
      associations.added = optionalAttrs enable {"inode/directory" = ["nautilus.desktop"];};
      defaultApplications = optionalAttrs enable {"inode/directory" = ["nautilus.desktop"];};
    };
  };
}
