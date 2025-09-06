{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
    theme = "default";
  };

  westonLite = pkgs.weston.override {
    demoSupport = false;
    jpegSupport = true;
    lcmsSupport = false;
    pangoSupport = false;
    pipewireSupport = true;
    rdpSupport = false;
    remotingSupport = false;
    vaapiSupport = false;
    vncSupport = false;
    webpSupport = false;
    xwaylandSupport = false;
  };

  westonCommand = let
    westonIni = (pkgs.formats.ini {}).generate "weston.ini" {
      libinput = {
        enable-tap = config.services.libinput.mouse.tapping;
        left-handed = config.services.libinput.mouse.leftHanded;
      };
      keyboard = {
        keymap_model = config.services.xserver.xkb.model;
        keymap_layout = config.services.xserver.xkb.layout;
        keymap_variant = config.services.xserver.xkb.variant;
        keymap_options = config.services.xserver.xkb.options;
      };
    };
  in "${lib.getExe westonLite} --shell=kiosk -c ${westonIni}";
in {
  environment.systemPackages = [sddm-theme pkgs.bibata-cursors];

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      wayland.compositorCommand = westonCommand;

      package = pkgs.kdePackages.sddm;

      theme = sddm-theme.pname;

      extraPackages = sddm-theme.propagatedBuildInputs;

      settings = {
        General = {
          GreeterEnvironment = "QT_SCREEN_SCALE_FACTORS=1.2,QML2_IMPORT_PATH=${sddm-theme}/theme/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
          InputMethod = "qtvirtualkeyboard";
        };

        Wayland = {
          EnableHiDPI = true;
        };

        Theme = {
          CursorTheme = "Bibata-Original-Ice";
          CursorSize = 24;
        };
      };
    };

    sessionPackages = [pkgs.niri];
  };

  system.activationScripts.copyFiles = {
    text = ''
      cp -r ${./sddm/faces}/* /var/lib/AccountsService/icons/
    '';
  };
}
