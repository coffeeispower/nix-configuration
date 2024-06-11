{
  lib,
  config,
  ...
}: {
  programs.nushell.shellAliases = lib.optionalAttrs config.programs.zoxide.enable {cd = "z";};
}
