{pkgs, inputs, ...}:
let
  inputImage = ./wallpaper.jpg;
  brightness = "10";
  contrast = "10";
  fillColor = "black";
in
{
  stylix.image = pkgs.runCommand "dimmed-background.png" { } ''
    ${pkgs.imagemagick}/bin/convert "${inputImage}" -brightness-contrast ${brightness},${contrast} -fill ${fillColor} $out
  '';
  stylix.polarity = "dark";
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
  stylix.fonts = with pkgs; {
    monospace = {
      package = (nerdfonts.override { fonts = [ "FiraCode" ]; });
      name = "FiraCodeNerdFontMono";
    };
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
    terminal = 0.9;
  };
}