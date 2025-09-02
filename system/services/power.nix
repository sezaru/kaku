{
  services = {
    logind = {
      powerKey = "suspend";
      lidSwitch = "suspend";
      lidSwitchExternalPower = "suspend";
    };

    power-profiles-daemon.enable = true;

    # Battery info
    upower = {
      enable = true;

      percentageLow = 30;
      percentageCritical = 20;
      percentageAction = 10;

      criticalPowerAction = "Hibernate";
    };
  };
}
