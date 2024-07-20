set shell := ["nu", "-c"]
default: test
# Rebuild the configuration with the same name as the hostname but don't create a new generation.
test: _generate-hardware-config
    doas nixos-rebuild test --flake . --impure

[private]
_generate-hardware-config:
    if not ("/tmp/hardware-configuration.nix" | path exists) { doas nixos-generate-config --show-hardware-config | str replace (open weird-docker-filesystem-part.txt) "" | save /tmp/hardware-configuration.nix -f }
# Rebuild the configuration but don't create a new generation
test-other HOSTNAME: _generate-hardware-config
    doas nixos-rebuild test --flake .#{{HOSTNAME}} --impure

# Rebuild the configuration with the same name as the hostname
switch: _generate-hardware-config
    doas nixos-rebuild switch --flake . --impure

boot: _generate-hardware-config
    doas nixos-rebuild boot --flake . --impure

# Rebuild the configuration.
switch-to-other HOSTNAME: _generate-hardware-config
    doas nixos-rebuild switch --flake .#{{HOSTNAME}} --impure

# Update all flake inputs
update:
  nix flake update

# Update only one input
update-one NAME:
  nix flake lock --update-input {{ NAME }}
	
# Build an ISO image from the `isoimage` Nix OS configuration
build-iso:
  nix build .#nixosConfigurations.isoimage.config.system.build.isoImage
