{pkgs, lib, config, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
  };
}