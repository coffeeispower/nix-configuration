{inputs, pkgs, lib, config, ...}: 
  let unstable = (import inputs.nixpkgs-unstable {}); in
{
  imports = [inputs.ags.homeManagerModules.default];
  programs.ags = {
    configDir = ./ags; # TODO: Change this to the actual config directory when it is done
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
  home.packages = lib.mkIf config.programs.ags.enable [
    unstable.bun
  ];
}
