{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-23.11"; };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      channels-config.allowUnfree = true;
      channels-config.permittedInsecurePackages = [
        "electron-25.9.0"
      ];
      src = ./.;
    };
}
