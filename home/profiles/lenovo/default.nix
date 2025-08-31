{
  imports = [
    # TODO Add emacs here
    # editors

    # services
    ../../services/quickshell

    # media services
    # ../../services/media/playerctl.nix

    # software
    ../../software
    ../../software/wayland

    # system services
    ../../services/system/gpg-agent.nix
    ../../services/system/polkit-agent.nix
    # ../../services/system/power-monitor.nix

    # terminal emulators
    # ../../terminal/emulators/foot.nix
  ];
}
