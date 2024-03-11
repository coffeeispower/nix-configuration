{pkgs, ...}:
{
  stylix.image = ./wallpaper.jpg;
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
  stylix.fonts = with pkgs; rec {
    monospace = {
      package = (nerdfonts.override { fonts = [ "FiraCode" ]; });
      name = "FiraCodeNerdFontMono";
    };
    sansSerif = monospace;
    serif = monospace;
  };

  # Add some fonts
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [ ipafont (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
  };
  stylix.opacity = {
    applications = 0.9;
    popups = 0.9;
    terminal = 0.5;
    desktop = 0.5;
  };
}
