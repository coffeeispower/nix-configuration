{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  options.programs.feh = {
    mimeApps.defaultAssociation.enable = mkEnableOption "opening images in feh by default";
  };
  config = let
    inherit (config.programs) feh;
  in {
    home.packages = [(mkIf feh.enable pkgs.feh)];
    xdg.mimeApps = rec {
      enable = feh.enable && feh.mimeApps.defaultAssociation.enable;
      associations.added = {
        "image/png" = ["feh.desktop"];
        "image/jpeg" = ["feh.desktop"];
        "image/webp" = ["feh.desktop"];
        "image/gif" = ["feh.desktop"];
        "image/bmp" = ["feh.desktop"];
        "image/svg+xml" = ["feh.desktop"];
        "image/tiff" = ["feh.desktop"];
        "image/apng" = ["feh.desktop"];
      };
      defaultApplications = mkIf enable associations.added;
    };
  };
}
