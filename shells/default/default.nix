{pkgs, stdenv}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    just
    alejandra
  ];
}
