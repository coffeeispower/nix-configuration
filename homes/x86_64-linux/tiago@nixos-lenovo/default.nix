{ config, pkgs, lib, inputs, ... }:
{
  home.stateVersion = "23.11";
  imports = [inputs.spicetify-nix.homeManagerModules.default];
}
