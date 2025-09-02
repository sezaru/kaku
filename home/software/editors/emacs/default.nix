{pkgs, ...}: {
  home.packages = [
    pkgs.fd
  ];

  programs.doom-emacs = {
    enable = true;

    emacs = pkgs.emacs-pgtk;
    extraPackages = epkgs: [epkgs.treesit-grammars.with-all-grammars];

    experimentalFetchTree = true;

    doomDir = ./doom;
  };
}
