alias default := test

test:
    doas nixos-rebuild test --flake .
test-other HOSTNAME:
    doas nixos-rebuild test --flake .#{{HOSTNAME}}

switch:
    doas nixos-rebuild switch --flake .
switch-to-other HOSTNAME:
    doas nixos-rebuild switch --flake .#{{HOSTNAME}}

update:
  nix flake update
update-one NAME:
  nix flake lock --update-input {{ NAME }}
