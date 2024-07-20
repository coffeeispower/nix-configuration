{ lib, pkgs, ... }: {
  programs.fastfetch.settings = builtins.fromJSON (builtins.readFile (lib.my-lib.mustache.template {
    inherit pkgs;
    name = "fastfetch-config";
    templateFile = ./fastfetch.jsonc;
    variables = {
      logoFile = builtins.toString ./nixos-white.png;
    };
  }));
}
