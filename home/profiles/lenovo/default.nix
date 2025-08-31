{
  imports = [
    # services
    ../../services/quickshell

    # software
    ../../software
    ../../software/wayland

    # system services
    ../../services/system/gpg-agent.nix
    ../../services/system/polkit-agent.nix
    # ../../services/system/power-monitor.nix
  ];
}
