{
  config,
  pkgs,
  lib,
  ...
}: {
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

  # This makes the battery charge stop at 80%
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", KERNEL=="macsmc-battery", ATTR{charge_control_start_threshold}="60", ATTR{charge_control_end_threshold}="80"
  '';

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

  environment.systemPackages = [pkgs.asahi-audio];

  services.pipewire.configPackages = lib.mkForce [];
  services.pipewire.wireplumber.configPackages = lib.mkForce [];

  hardware.apple.touchBar = {
    enable = true;

    package = pkgs.tiny-dfr.overrideAttrs (old: {
      postInstall =
        (old.postInstall or "")
        + ''
          mkdir -p $out/share
          cp ${./tiny-dfr/print.svg} $out/share/tiny-dfr/print.svg
        '';
    });

    settings = {
      # F{number} keys are shown when Fn is not pressed by default.
      # Set this to true if you want the media keys to be shown without Fn pressed
      MediaLayerDefault = true;

      # Set this to false if you want to hide the button outline,
      # leaving only the text/logo
      ShowButtonOutlines = true;

      # Set this to true to slowly shift the entire screen contents.
      # In theory this helps with screen longevity, but macos does not bother doing it
      # Disabling ShowButtonOutlines will make this effect less noticeable to the eye
      EnablePixelShift = true;

      # This key defines the contents of the primary layer
      # (the one with F{number} keys)
      # You can change the individual buttons, add, or remove them
      # Any number of keys that is greater than 0 is allowed
      # however rendering will start to break around 24 keys
      # Buttons can be made larger by setting the optional Stretch field
      # to a number greater than 1 (which means the button will take up
      # that many button spaces).
      PrimaryLayerKeys = [
        # Action defines the key code to send when the button is pressed
        # Text defines the button label
        # Icon specifies the icon to be used for the button.
        # Theme specifies the XDG icons theme.
        # Stretch specifies how many button spaces the button should take up
        # and defaults to 1
        # Icons can either be svgs or pngs, with svgs being preferred
        # For best results with pngs, they should be 48x48
        # Do not include the extension in the file name.
        # If a Theme is set, icons are looked up in XDG_DATA_DIRS.
        # Otherwise, they are first looked up in /etc/tiny-dfr, and then in /usr/share/tiny-dfr.
        # Time can be either 24hr, or 12hr. Locale is optional and will default to POSIX.
        # Only one of Text, Icon or Time is allowed,
        # if both are present, the behavior is undefined.
        # For the list of supported key codes see
        # https://docs.rs/input-linux/latest/input_linux/enum.Key.html
        # Note that the escape key is not specified here, as it is added
        # automatically on Macs without a physical one
        {
          Text = "F1";
          Action = "F1";
        }
        {
          Text = "F2";
          Action = "F2";
        }
        {
          Text = "F3";
          Action = "F3";
        }
        {
          Text = "F4";
          Action = "F4";
        }
        {
          Text = "F5";
          Action = "F5";
        }
        {
          Text = "F6";
          Action = "F6";
        }
        {
          Text = "F7";
          Action = "F7";
        }
        {
          Text = "F8";
          Action = "F8";
        }
        {
          Text = "F9";
          Action = "F9";
        }
        {
          Text = "F10";
          Action = "F10";
        }
        {
          Text = "F11";
          Action = "F11";
        }
        {
          Text = "F12";
          Action = "F12";
        }
      ];

      # This key defines the contents of the media key layer
      MediaLayerKeys = [
        {
          Icon = "brightness_low";
          Action = "BrightnessDown";
        }
        {
          Icon = "brightness_high";
          Action = "BrightnessUp";
        }
        # {
        #   Icon = "search";
        #   Action = "Search";
        # }
        {
          Icon = "backlight_low";
          Action = "IllumDown";
        }
        {
          Icon = "backlight_high";
          Action = "IllumUp";
        }
        {
          Icon = "fast_rewind";
          Action = "PreviousSong";
        }
        {
          Icon = "play_pause";
          Action = "PlayPause";
        }
        {
          Icon = "fast_forward";
          Action = "NextSong";
        }
        {
          Text = "Home";
          Action = "Home";
        }
        {
          Text = "End";
          Action = "End";
        }
        {
          Icon = "print";
          Action = "Print";
        }
        {
          Icon = "mic_off";
          Action = "MicMute";
        }
        {
          Icon = "volume_off";
          Action = "Mute";
        }
        {
          Icon = "volume_down";
          Action = "VolumeDown";
        }
        {
          Icon = "volume_up";
          Action = "VolumeUp";
        }
      ];
    };
  };
}
