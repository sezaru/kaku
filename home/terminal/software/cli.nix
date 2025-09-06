{pkgs, ...}: {
  home.packages = with pkgs; [
    # Archives
    zip
    unzip
    unrar

    # Utils
    killall
  ];

  programs = {
    eza.enable = true;
    dircolors.enable = true;

    ssh = {
      enable = true;
      enableDefaultConfig = true;
    };
  };
}
