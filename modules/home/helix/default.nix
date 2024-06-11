{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.helix = {
    defaultEditor = true;
  };
}
