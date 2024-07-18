{
  pkgs,
}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    just
    alejandra
    nushell
  ];
}
