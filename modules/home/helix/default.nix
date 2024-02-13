{pkgs, lib, config, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings.theme = "base16nix";
    themes.base16nix = {
      "attributes" = "base09";
      "comment" = {
        fg = "base03";
        modifiers = [ "italic" ];
      };
      "constant" = "base09";
      "constant.character.escape" = "base0C";
      "constant.numeric" = "base09";
      "constructor" = "base0D";
      "debug" = "base03";
      "diagnostic" = { modifiers = [ "underlined" ]; };
      "diff.delta" = "base09";
      "diff.minus" = "base08";
      "diff.plus" = "base0B";
      "error" = "base08";
      "function" = "base0D";
      "hint" = "base03";
      "info" = "base0D";
      "keyword" = "base0E";
      "label" = "base0E";
      "namespace" = "base0E";
      "operator" = "base05";
      "special" = "base0D";
      "string" = "base0B";
      "type" = "base0A";
      "variable" = "base08";
      "variable.other.member" = "base0B";
      "warning" = "base09";

      "markup.bold" = {
        fg = "base0A";
        modifiers = [ "bold" ];
      };
      "markup.heading" = "base0D";
      "markup.italic" = {
        fg = "base0E";
        modifiers = [ "italic" ];
      };
      "markup.link.text" = "base08";
      "markup.link.url" = {
        fg = "base09";
        modifiers = [ "underlined" ];
      };
      "markup.list" = "base08";
      "markup.quote" = "base0C";
      "markup.raw" = "base0B";
      "markup.strikethrough" = { modifiers = [ "crossed_out" ]; };

      "diagnostic.hint" = { underline = { style = "curl"; }; };
      "diagnostic.info" = { underline = { style = "curl"; }; };
      "diagnostic.warning" = { underline = { style = "curl"; }; };
      "diagnostic.error" = { underline = { style = "curl"; }; };

      "ui.bufferline.active" = {
        fg = "base00";
        modifiers = [ "bold" ];
      };
      "ui.bufferline" = { fg = "base04"; };
      "ui.cursor" = {
        fg = "base0A";
        modifiers = [ "reversed" ];
      };
      "ui.cursor.insert" = {
        fg = "base0A";
        modifiers = [ "reversed" ];
      };
      "ui.cursorline.primary" = {
        fg = "base05";
        bg = "base01";
      };
      "ui.cursor.match" = {
        fg = "base0A";
        modifiers = [ "reversed" ];
      };
      "ui.cursor.select" = {
        fg = "base0A";
        modifiers = [ "reversed" ];
      };
      "ui.gutter" = { bg = "base00"; };
      "ui.help" = { fg = "base06"; };
      "ui.linenr" = { fg = "base03"; };
      "ui.linenr.selected" = {
        fg = "base04";
        modifiers = [ "bold" ];
      };
      "ui.menu" = { fg = "base05"; };
      "ui.menu.scroll" = { fg = "base03"; };
      "ui.menu.selected" = { fg = "base01"; };
      "ui.popup" = { bg = "base01"; };
      "ui.selection" = { bg = "base02"; };
      "ui.selection.primary" = { bg = "base02"; };
      "ui.statusline" = { fg = "base04"; };
      "ui.statusline.inactive" = { fg = "base03"; };
      "ui.statusline.insert" = { fg = "base00"; };
      "ui.statusline.normal" = { fg = "base00"; };
      "ui.statusline.select" = { fg = "base00"; };
      "ui.text" = "base05";
      "ui.text.focus" = "base05";
      "ui.virtual.indent-guide" = { fg = "base03"; };
      "ui.virtual.inlay-hint" = { fg = "base01"; };

      palette = (lib.attrsets.mapAttrs (name: value: "#" + value)
        config.colorScheme.palette);
    };
  };
}