{
  config,
  lib,
  ...
}: {
  programs.nushell = lib.optionalAttrs config.programs.kitty.enable {extraConfig = "$env.config.shell_integration = true";};
}
