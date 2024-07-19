{ ... }: {
  programs.fastfetch.settings = builtins.fromJSON (builtins.readFile ./fastfetch.jsonc);
}
