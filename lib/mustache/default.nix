{inputs, ...}: {
  mustache.template = {
    pkgs,
    name,
    templateFile,
    variables,
  }:
    pkgs.stdenv.mkDerivation {
      inherit name;

      # Pass Json as file to avoid escaping
      passAsFile = ["jsonVariables"];
      jsonVariables = builtins.toJSON variables;

      # Disable phases which are not needed. In particular the unpackPhase will
      # fail, if no src attribute is set
      phases = ["buildPhase" "installPhase"];

      buildPhase = ''
        ${pkgs.mustache-go}/bin/mustache $jsonVariablesPath ${templateFile} > rendered_file
      '';

      installPhase = ''
        cp rendered_file $out
      '';
    };
}
