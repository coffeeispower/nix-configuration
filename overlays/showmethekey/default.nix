{...}:

final: prev: {
  showmethekey = prev.showmethekey.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "coffeeispower";
      repo = "showmethekey";
      rev = "6f9bbc2ff67953f686e5599bd7dea2cd2a5c6375";
      sha256 = "sha256-Pgz0MS62nCdSCJ/CeFjXaqnqnJfV6PztORMcAzaD8wE=";
    };

    nativeBuildInputs = old.nativeBuildInputs ++ [ prev.gtk4-layer-shell ];
  });
}
