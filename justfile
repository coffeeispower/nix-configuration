alias default := test

# Rebuild the configuration with the same name as the hostname but don't create a new generation.
test:
    doas nixos-rebuild test --flake .

# Rebuild the configuration but don't create a new generation
test-other HOSTNAME:
    doas nixos-rebuild test --flake .#{{HOSTNAME}}

# Rebuild the configuration with the same name as the hostname
switch:
    doas nixos-rebuild switch --flake .

# Rebuild the configuration.
switch-to-other HOSTNAME:
    doas nixos-rebuild switch --flake .#{{HOSTNAME}}

# Update all flake inputs
update:
  nix flake update

# Update only one input
update-one NAME:
  nix flake lock --update-input {{ NAME }}
	
# Build an ISO image from the `isoimage` Nix OS configuration
build-iso:
  nix build .#nixosConfigurations.isoimage.config.system.build.isoImage
