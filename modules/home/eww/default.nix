{
  lib,
  config,
  pkgs,
  ...
}: {
  xdg.configFile."eww" = lib.mkIf config.programs.eww.enable {recursive = true;};
  home.packages = lib.mkIf config.programs.eww.enable [
    pkgs.playerctl
    (pkgs.writeShellScriptBin "getArtUrl" ''
      # Directory where album art images will be stored
      ART_DIR="/tmp/music_art"

      # Create the directory if it doesn't exist
      mkdir -p "$ART_DIR"

      # Function to clean up old files
      cleanup_old_files() {
          # Delete files older than 1 day
          find "$ART_DIR" -type f -mtime +1 -exec rm -f {} +
      }

      while IFS= read -r url; do
          if [ -n "$url" ]; then
              # Calculate the hash of the URL
              filename=$(echo -n "$url" | md5sum | cut -d ' ' -f1)
              localpath="$ART_DIR/$filename.jpg"  # Assuming JPEG format for simplicity
              # Download the image if it doesn't already exist
              if [ ! -f "$localpath" ]; then
                  ${pkgs.curl}/bin/curl -o "$localpath" "$url"
              fi
              echo "$localpath"
              # Clean up old files after fetching new one
              cleanup_old_files
          fi
      done < <(${pkgs.playerctl}/bin/playerctl --follow metadata --format '{{ mpris:artUrl }}' || true)
    '')
  ];
  programs.eww.configDir = pkgs.stdenv.mkDerivation {
    src = ./.;
    name = "eww-config";
    installPhase = ''
      mkdir -p $out
      cp ${
        lib.my-lib.mustache.template {
          inherit pkgs;
          name = "eww-config-scss";
          templateFile = ./eww.scss.mustache;
          variables =
            config.stylix.base16Scheme
            // {
              desktopOpacity = builtins.toString config.stylix.opacity.desktop;
              font = config.stylix.fonts.sansSerif.name;
            };
        }
      } $out/eww.scss
      cp *.yuck $out/
    '';
  };
}
