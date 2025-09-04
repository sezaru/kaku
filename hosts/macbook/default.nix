{config, ...}: {
  imports = [./hardware-configuration.nix];

  boot = {
    kernelModules = ["v4l2loopback" "i2c-dev"];

    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];

    kernelParams = [
      "nvme_core.default_ps_max_latency_us=0"

      # Enables the pixels horizontal of the notch.
      # "apple_dcp.show_notch=1"

      # Default on asahi fedora.
      "zswap.enabled=1"
      "zswap.compressor=lz4"
      "zswap.zpool=z3fold"
    ];

    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;

      "kernel.nmi_watchdog" = 0;
    };

    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="OBS Virtual Output"
    '';
  };

  networking.hostName = "macbook";

  security.tpm2.enable = true;

  services = {
    # For SSD/NVME
    fstrim.enable = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  hardware.asahi = {
    setupAsahiSound = true;

    # Specify path to peripheral firmware files.
    peripheralFirmwareDirectory = ./firmware;
  };

  # TODO Check if this is needed
  # services.udev = {
  #   extraRules = ''
  #     # Allow backlight control for non-root users.
  #     ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="apple-panel-bl", RUN+="${pkgs.coreutils}/bin/chmod 0664 /sys/class/backlight/apple-panel-bl/brightness"
  #   '';
  # };
}
