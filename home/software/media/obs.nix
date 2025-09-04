{
  pkgs,
  vars,
  ...
}: let
  name = vars.name;

  lenovoPlugins = with pkgs.obs-studio-plugins; [
    obs-gstreamer
    obs-pipewire-audio-capture
    obs-vaapi
  ];

  macbookPlugins = with pkgs.obs-studio-plugins; [
    obs-gstreamer
    obs-vaapi
  ];
in {
  programs.obs-studio = {
    enable = true;

    plugins =
      if name == "lenovo"
      then lenovoPlugins
      else if name == "macbook"
      then macbookPlugins
      else abort "Unknown name";

    package = pkgs.symlinkJoin {
      name = "obs-studio";

      paths = [
        (pkgs.obs-studio.override {
          pipewireSupport = true;
          browserSupport = true;
        })
      ];

      buildInputs = [pkgs.makeWrapper];

      postBuild = ''
        wrapProgram $out/bin/obs \
          --add-flags "--ozone-platform=wayland"
      '';
    };
  };
}
