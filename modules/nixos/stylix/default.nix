{pkgs, ...}: {
  stylix.image = ./wallpaper.png;
  stylix.cursor = {
    package = pkgs.catppuccin-cursors.frappeMauve;
    name = "catppuccin-frappe-mauve-cursors";
    size = 32;
  };
  stylix.base16Scheme = 
    let
      jsonOutputDrv =
        pkgs.runCommand
          "from-yaml"
          { nativeBuildInputs = [ pkgs.remarshal ]; }
          "remarshal -if yaml -i \"${./colorscheme.yaml}\" -of json -o \"$out\"";
    in
    builtins.fromJSON (builtins.readFile jsonOutputDrv);
  stylix.polarity = "dark";
  stylix.fonts = rec {
    monospace = {
      package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
      name = "FiraCodeNerdFontMono";
    };
    sansSerif = {
      package = pkgs.inter;
      name = "InterVariable";
    };
    serif = sansSerif;
  };

  # Add some fonts
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [ ipafont ];
  };
  stylix.opacity = {
    applications = 0.9;
    popups = 0.9;
    terminal = 0.5;
    desktop = 0.5;
  };
  stylix.targets.plymouth.logo = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
  stylix.enable = true;
}
