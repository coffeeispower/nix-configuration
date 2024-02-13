{ config, pkgs, lib, inputs, system, ... }:
{
  colorScheme = inputs.nix-colors.colorSchemes.material-darker;
  home.stateVersion = "23.11";
}
