{inputs, ...}:

final: prev: {
  swww = inputs.swww.packages.${prev.system}.swww;
}
