{ neovide, neovim, lunarvim, writeShellScriptBin }:

writeShellScriptBin "lvimgui" ''
export LUNARVIM_RUNTIME_DIR="''${LUNARVIM_RUNTIME_DIR:-"$HOME/.local/share/lunarvim"}"
export LUNARVIM_CONFIG_DIR="''${LUNARVIM_CONFIG_DIR:-"$HOME/.config/lvim"}"
export LUNARVIM_CACHE_DIR="''${LUNARVIM_CACHE_DIR:-"$HOME/.cache/lvim"}"
export LUNARVIM_BASE_DIR="''${LUNARVIM_BASE_DIR:-"${lunarvim}/share/lvim"}"

exec ${neovide}/bin/neovide --neovim-bin ${neovim}/bin/nvim -- -u "$LUNARVIM_BASE_DIR/init.lua" "$@"
''
