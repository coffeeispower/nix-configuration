{...}: {
  programs.nushell = {
    shellAliases = {lg = "lazygit";};
    envFile.source = ./env.nu;
  };
}
