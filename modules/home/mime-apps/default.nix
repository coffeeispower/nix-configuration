{...}: {
  xdg.mimeApps = let
    associations = {
      "inode/directory" = [ "thunar.desktop" ];
      "image/png" = [ "feh.desktop" ];
      "image/jpeg" = [ "feh.desktop" ];
      "image/webp" = [ "feh.desktop" ];
      "image/gif" = [ "feh.desktop" ];
      "image/bmp" = [ "feh.desktop" ];
      "image/svg+xml" = [ "feh.desktop" ];
      "image/tiff" = [ "feh.desktop" ];
      "image/apng" = [ "feh.desktop" ];
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
    };
  in {
    enable = true;
    associations.added = associations;
    defaultApplications = associations;
  };
}