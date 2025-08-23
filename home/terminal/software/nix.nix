{
  pkgs,
  self,
  ...
}:
# nix tooling
{
  home.packages = with pkgs; [
    # Uncompromising Nix Code Formatter
    alejandra
    # Find and remove unused code in .nix source files
    deadnix
    # Lints and suggestions for the nix programming language
    statix

    self.packages.${pkgs.system}.repl
  ];

  programs.direnv = {
    enable = true;
    # enableNushellIntegration = true;
    nix-direnv.enable = true;
    silent = true;
  };
}
