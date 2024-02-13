{ config, pkgs, lib, inputs, system, ... }:
{
  home.stateVersion = "23.11";
  stylix.targets.vscode.enable= false;
}
