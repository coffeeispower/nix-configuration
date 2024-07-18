{...}: {
  programs.nushell = {
    shellAliases = {lg = "lazygit";};
    envFile.source = ./env.nu;
    configFile.text = ''
      $env.config.show_banner = false;
    '';
  };
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };
}
