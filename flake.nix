{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-23.11"; };
    nixpkgs-unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };
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
    stylix = {
      url = "github:coffee-is-power/stylix/release-23.11";
      inputs.home-manager.follows = "home-manager";
    };
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-rice = { url = "github:bertof/nix-rice"; };
    slides = {
      url = "github:maaslalani/slides";
      flake = false;
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      channels-config.allowUnfree = true;
      channels-config.permittedInsecurePackages = [
        "electron-25.9.0"
      ];
      src = ./.;
      snowfall.namespace = "my-lib";
      systems.modules.nixos = [ inputs.stylix.nixosModules.stylix ];
    };
}
