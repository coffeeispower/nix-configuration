{...}: {
  programs.nushell = {
    shellAliases = {lg = "lazygit";};
    envFile.source = ./env.nu;
  };
  programs.starship = { enable = true; enableNushellIntegration = true; };
}
