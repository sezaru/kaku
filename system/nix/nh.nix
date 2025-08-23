_: {
  # nh default flake
  # TODO Now sure if this is needed or not
  # environment.variables.NH_FLAKE = "/home/sezdocs/Dev/nixland";

  programs.nh = {
    enable = true;
    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
  };
}
