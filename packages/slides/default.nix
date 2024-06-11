{
  lib,
  bash,
  buildGoModule,
  fetchFromGitHub,
  go,
  inputs,
}:
buildGoModule rec {
  pname = "slides";
  version = "0.10.0-beta";

  src = inputs.slides;

  nativeCheckInputs = [
    bash
    go
  ];

  vendorHash = "sha256-oV3UcbOC4y8xWnA5qZGEK/TRdQ4zCeZshgBAs2l+vSY=";

  ldflags = [
    "-s"
    "-w"
    "-X=main.Version=${version}"
  ];

  meta = with lib; {
    description = "Terminal based presentation tool";
    homepage = "https://github.com/maaslalani/slides";
    changelog = "https://github.com/maaslalani/slides/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [maaslalani penguwin];
  };
}
