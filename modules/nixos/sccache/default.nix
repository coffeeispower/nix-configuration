{pkgs, ...}: {
  environment.variables.RUSTC_WRAPPER = "${pkgs.sccache}/bin/sccache";
}
