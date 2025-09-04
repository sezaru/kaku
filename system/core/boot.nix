{
  config,
  pkgs,
  ...
}: {
  boot = {
    bootspec.enable = true;

    initrd.systemd.enable = true;

    consoleLogLevel = 3;

    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "plymouth.use-simpledrm"
    ];

    plymouth.enable = true;

    tmp = {
      useTmpfs = false;
      cleanOnBoot = true;
    };
  };

  systemd.services.nix-daemon = {
    environment = {
      TMPDIR = "/var/tmp";
    };
  };

  environment.systemPackages = [config.boot.kernelPackages.cpupower];
}
