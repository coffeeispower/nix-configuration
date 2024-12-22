{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-24.11"; };
    nixpkgs-unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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
      url = "github:danth/stylix/master";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nix-rice = {url = "github:bertof/nix-rice";};
    slides = {
      url = "github:maaslalani/slides";
      flake = false;
    };
    comfy-theme-spicetify = {
      url = "github:Comfy-Themes/Spicetify";
      flake = false;
    };
    spicetify-furigana-lyrics = {
      url = "github:duffey/spicetify-furigana-lyrics";
      flake = false;
    };
    woomer = {
      url = "github:coffeeispower/woomer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    ags.url = "github:aylur/ags"; 
    ags-desktop= {
      url = "github:coffeeispower/ags-desktop";
      inputs= {
        nixpkgs.follows = "nixpkgs";
        ags.follows = "ags";
      };
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
