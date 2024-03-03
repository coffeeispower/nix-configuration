{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    userSettings = {
      "editor.fontLigatures" = true;
      "git.confirmSync" = false;
      "workbench.colorTheme" = "Tomorrow Night Blue";
      "vscord.status.problems.text" = "{problems_count} erros";
  
      "vscord.status.details.text.debugging" = "Deu merda na {workspace} e tou a debugar";
      "vscord.status.state.text.debugging" = "A debugar o arquivo {file_name}{file_extension}";
  
      "vscord.status.details.text.editing" = "A mexer no {file_name}{file_extension}:{current_line}:{current_column}";
      "vscord.status.state.text.editing" = "No projeto {workspace} (com {problems})";
  
      "vscord.status.details.text.notInFile" = "Não tou a editar nada";
      "vscord.status.state.text.notInFile" = "Lembrei-me de procrastinar mais um pouco...";
  
      "vscord.status.details.text.idle" = "AFK";
      "vscord.status.state.text.idle" = "Fui fazer outra cena mas esqueci o vscode aberto...";

      "vscord.status.details.text.viewing" = "A mexer no arquivo {file_name}{file_extension}";
      "vscord.status.state.text.viewing" = "No projeto {workspace} (com {problems})";
  
      "vscord.status.state.text.noWorkspaceFound" = "A usar o vscode só pra editar um arquivo...";
      "vscord.status.details.text.noWorkSpaceText" = "A usar uma espada pra cortar um pão";

      "vscord.status.image.large.viewing.text" = "A ver código {LANG}";
      "vscord.status.image.small.viewing.text" = "Visual Studio Code";

      "vscord.status.image.large.editing.text" = "A mexer com {LANG}";
      "vscord.status.image.small.editing.text" = "Visual Studio Code";


      "vscord.status.image.small.notInFile.text" = "Visual Studio Code";
      "vscord.status.image.small.notInFile.key" = "https://raw.githubusercontent.com/LeonardSSH/vscord/main/assets/icons/vscode.png";

      "vscord.status.image.large.notInFile.text" = "A procrastinar provavelmente...";
      "vscord.status.image.large.notInFile.key" = "https://i.fbcd.co/products/original/454-97eae28d51681f0d1ffd5fcf220989abd5367188fc57b26d5b7d69da5b46252b.jpg";

      "vscord.status.image.large.idle.text" = "AFK";
      "vscord.status.image.large.idle.key" = "https://raw.githubusercontent.com/LeonardSSH/vscord/main/assets/icons/idle.png";
      "vscord.status.idle.timeout" = 300;
      "vscord.status.idle.resetElapsedTime" = true;
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
#        jdinhlife.gruvbox
        editorconfig.editorconfig
        tamasfe.even-better-toml
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
