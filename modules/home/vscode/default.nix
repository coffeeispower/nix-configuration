{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    userSettings = {
      "workbench.colorTheme" = "Gruvbox Dark Hard";
      "git.confirmSync" = false;
    };
    extensions = with pkgs.vscode-extensions;
      [
        jnoortheen.nix-ide
        mkhl.direnv
        usernamehw.errorlens
        dart-code.flutter
        dart-code.dart-code
        davidanson.vscode-markdownlint
        svelte.svelte-vscode
        rust-lang.rust-analyzer
        llvm-vs-code-extensions.vscode-clangd
        jdinhlife.gruvbox
        editorconfig.editorconfig
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          publisher = "slushnys";
          name = "worktreesnuts";
          version = "1.0.2";
          sha256 = "sha256-BS4FxwnohVA+qaFZXJDfUDQv4Gh4accTIZ5BhxIa3xI=";
        }
        {
          publisher = "LeonardSSH";
          name = "vscord";
          version = "5.1.18";
          sha256 = "sha256-pJ9loVW1uhlITXSNBsCEgW+o3ABn0cxcZxg6S7cKWHI=";
        }
        {
          publisher = "aaron-bond";
          name = "better-comments";
          version = "3.0.2";
          sha256 = "sha256-hQmA8PWjf2Nd60v5EAuqqD8LIEu7slrNs8luc3ePgZc=";
        }
        {
          publisher = "naumovs";
          name = "color-highlight";
          version = "2.5.0";
          sha256 = "sha256-dYMDV84LEGXUjt/fbsSy3BVM5SsBHcPaDDll8KjPIWY=";
        }
        {
          name = "yuck";
          publisher = "eww-yuck";
          version = "0.0.3";
          sha256 = "sha256-DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
        }
        {
          name = "vsliveshare";
          publisher = "MS-vsliveshare";
          version = "1.0.5900";
          sha256 = "sha256-syVW/aS2ppJjg4OZaenzGM3lczt+sLy7prwsYFTDl9s=";
        }
        {
          name = "vscode-nushell-lang";
          publisher = "thenuprojectcontributors";
          version = "1.7.1";
          sha256 = "sha256-JlkZ8rarwTdQpiR76RR1s4XgH+lOIXfa0rAwLxvoYUc=";
        }
        {
          name = "intellij-idea-keybindings";
          publisher = "k--kato";
          version = "1.5.12";
          sha256 = "sha256-khXO8zLwQcdqiJxFlgLQSQbVz2fNxFY6vGTuD1DBjlc=";
        }
        {
          name = "arb-editor";
          publisher = "Google";
          version = "0.0.12";
          sha256 = "sha256-1egXFSDBe2njR4gI3mr+2Hu5TddP2VHkxjdgwCwXXU4=";
        }
      ];
  };
}