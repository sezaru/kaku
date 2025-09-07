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

        desktop = {
          hostname = "192.168.1.85";
          user = "sezdocs";
        };

        # These should be only for work
        marketplace-prod = {
          hostname = "3.87.215.30";
          port = 2240;
          user = "ubuntu";
          setEnv = {
            "TERM" = "xterm-256color";
          };
        };

        marketplace-dev = {
          hostname = "192.168.0.19";
          port = 2240;
          user = "ubuntu";
          setEnv = {
            "TERM" = "xterm-256color";
          };
        };

        pacman-prod = {
          hostname = "192.168.0.104";
          user = "ubuntu";
          setEnv = {
            "TERM" = "xterm-256color";
          };
        };

        pacman-dev = {
          hostname = "192.168.0.56";
          user = "ubuntu";
          setEnv = {
            "TERM" = "xterm-256color";
          };
        };
      };
    };
  };
}
