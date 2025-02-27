{ pkgs, ... }:
{
  programs = {
    zsh.shellAliases."c" = "codium .";
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      mutableExtensionsDir = false;

      extensions =
        with pkgs.vscode-extensions;
        [
          bbenoist.nix
          jnoortheen.nix-ide
          timonwong.shellcheck
          esbenp.prettier-vscode
          foxundermoon.shell-format
          streetsidesoftware.code-spell-checker
          james-yu.latex-workshop
          ms-vscode.cpptools
          golang.go
          davidanson.vscode-markdownlint
          ms-kubernetes-tools.vscode-kubernetes-tools
          redhat.vscode-yaml
          rust-lang.rust-analyzer
          ms-vsliveshare.vsliveshare
          zxh404.vscode-proto3
          tamasfe.even-better-toml
          arjun.swagger-viewer
          ms-azuretools.vscode-docker
          eamodio.gitlens
          vscodevim.vim
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "vscode-drawio";
            publisher = "hediet";
            version = "1.6.6";
            sha256 = "sha256-SPcSnS7LnRL5gdiJIVsFaN7eccrUHSj9uQYIQZllm0M=";
          }
          {
            name = "vscode-protolint";
            publisher = "plex";
            version = "0.8.0";
            sha256 = "sha256-DTKWQYRQkV1VTCnuDxakI7mjyMFF55Ppss/QRwjWIog=";
          }
        ];

      userSettings = builtins.fromJSON (builtins.readFile ./settings.json) // {
        "shellformat.path" = "${pkgs.shfmt}/bin/shfmt";
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {
              # "command" = [ "${pkgs.alejandra}/bin/alejandra" ];
              "command" = [ "${pkgs.nixfmt-rfc-style}/bin/nixfmt" ];
            };
          };
        };
      };
    };
  };
}
