{pkgs, ...}: {
  stylix.image = ./wallpaper.png;
  stylix.cursor = {
    package = pkgs.catppuccin-cursors.frappeMauve;
    name = "Catppuccin-Frappe-Mauve-Cursors";
    size = 8;
  };
  stylix.base16Scheme = {
    scheme = "Catppuccin Macchiato";
    author = "https://github.com/catppuccin/catppuccin";
    # #24273a
    base00 = "24273a"; # base
    # #1e2030
    base01 = "1e2030"; # mantle
    # #363a4f
    base02 = "363a4f"; # surface0
    # #494d64
    base03 = "494d64"; # surface1
    # #5b6078
    base04 = "5b6078"; # surface2
    # #cad3f5
    base05 = "cad3f5"; # text
    # #f4dbd6
    base06 = "f4dbd6"; # rosewater
    # #b7bdf8
    base07 = "b7bdf8"; # lavender
    # #ed8796
    base08 = "ed8796"; # red
    # #f5a97f
    base09 = "f5a97f"; # peach
    # #eed49f
    base0A = "eed49f"; # yellow
    # #a6da95
    base0B = "a6da95"; # green
    # #8bd5ca
    base0C = "8bd5ca"; # teal
    # #8aadf4
    base0D = "8aadf4"; # blue
    # #c6a0f6
    base0E = "c6a0f6"; # mauve
    # #f0c6c6
    base0F = "f0c6c6"; # flamingo
  };
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
