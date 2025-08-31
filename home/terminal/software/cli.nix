{pkgs, ...}: {
  # TODO Review all pkgs here
  home.packages = with pkgs; [
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
  ];

  programs = {
    eza.enable = true;

    ssh.enable = true;

    dircolors = {
      enable = true;
    };
  };
}
