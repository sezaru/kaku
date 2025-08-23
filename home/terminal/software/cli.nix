{
  inputs,
  pkgs,
  ...
}: {
  # TODO Review all pkgs here
  home.packages = with pkgs;
    [
      # archives
      zip
      unzip
      unrar

      # misc
      libnotify
      fontconfig

      # utils
      du-dust
      duf
      fd
      file
      jaq
      ripgrep
      killall
      jq
    ]
    ++ (with inputs.mynixpkgs.packages.${pkgs.system}; [
      opencode
      toney
      bmm
      omm
      prs
      dfft
      crush
    ]);

  programs = {
    eza.enable = true;
    ssh.enable = true;
    dircolors = {
      enable = true;
      # enableNushellIntegration = true;
    };
    autojump = {
      enable = true;
      # enableNushellIntegration = true;
    };
  };
}
