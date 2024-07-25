{inputs, pkgs, ...}: 
  let unstable = (import inputs.nixpkgs-unstable {}); in
{
  imports = [inputs.ags.homeManagerModules.default];
  programs.ags = {
    enable = true;
    configDir = ./ags; # TODO: Change this to the actual config directory when it is done
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
  home.packages = [
    unstable.bun
  ];
}
