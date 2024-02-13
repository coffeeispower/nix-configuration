{...}: {
  programs.nushell = {
    enable = true;
    shellAliases = { lg = "lazygit"; };
    envFile.source = ./env.nu;
  };
}