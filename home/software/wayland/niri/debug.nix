{vars, ...}: let
  gpu = vars.gpu;

  amd = {};

  mac = {
    # render-drm-device = "/dev/dri/card0";
    # render-drm-device = "/dev/dri/card1";
    # render-drm-device = "/dev/dri/card2";
    # render-drm-device = "/dev/dri/card3";
    # render-drm-device = "/dev/dri/renderD128";
  };
in {
  programs.niri.settings.debug =
    if gpu == "amd"
    then amd
    else if gpu == "mac"
    then mac
    else abort "Unknown gpu name";
}
