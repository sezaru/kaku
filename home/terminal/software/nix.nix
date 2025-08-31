{pkgs, ...}:
# nix tooling
{
  home.packages = with pkgs; [
    # Uncompromising Nix Code Formatter
    alejandra
    # Find and remove unused code in .nix source files
    deadnix
    # Lints and suggestions for the nix programming language
    statix
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
  };
}
