{ config, pkgs, lib, inputs, ... }:
{
  home.stateVersion = "23.11";
  imports = [inputs.spicetify-nix.homeManagerModules.default];
  stylix.targets.vscode.enable = false;
  stylix.targets.zellij.enable = false;
}
