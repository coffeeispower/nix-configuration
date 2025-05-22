{pkgs, config, ...}: {
  stylix.image = ../../home/hyprland/wallpapers/japan/shinjuku-tokyo-japan-night.jpg;
  stylix.cursor = {
    package = pkgs.catppuccin-cursors.frappeMauve;
    name = "catppuccin-frappe-mauve-cursors";
    size = 24;
  };
  stylix.base16Scheme = ./colorscheme.yaml;
  stylix.polarity = "dark";
  stylix.fonts = rec {
    monospace = {
      package = pkgs.nerd-fonts.ubuntu-sans;
      name = "UbuntuSansMonoNerdFontMono";
    };
    sansSerif = {
      package = pkgs.nerd-fonts.ubuntu-sans;
      name = "UbuntuSansNerdFont";
    };
    serif = sansSerif;
  };

  # Add some fonts
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [ rictydiminished-with-firacode noto-fonts-cjk-sans ];
  };
  stylix.opacity = {
    applications = 0.9;
    popups = 0.9;
    terminal = 0.5;
    desktop = 0.5;
  };
  stylix.targets.plymouth = {
    logo = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
    logoAnimated = false;
  };
  stylix.enable = true;
}
