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
      enableDefaultConfig = false;

      matchBlocks = {
        truenas = {
          hostname = "192.168.1.201";
          user = "admin";
          setEnv = {
            "TERM" = "xterm-256color";
          };
        };

        devenv = {
          hostname = "192.168.1.203";
          port = 2022;
          user = "sezdocs";
          setEnv = {
            "TERM" = "xterm-256color";
          };
        };
      };
    };
  };
}
