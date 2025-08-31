{pkgs, ...}: {
  services.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };

    sessionPackages = [pkgs.niri];
  };
}
