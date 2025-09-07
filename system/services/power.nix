{
  services = {
    logind.settings.Login = {
      HandlePowerKey = "suspend";
      HandlePowerKeyLongPress = "poweroff";
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
      HandleSwitchDocked = "ignore";
    };

    # TODO We are missing performance power
    power-profiles-daemon.enable = true;

    # Battery info
    upower = {
      enable = true;

      percentageLow = 30;
      percentageCritical = 20;
      percentageAction = 10;

      criticalPowerAction = "Hibernate";
    };

    # # TODO TLP allows to set the battery threshold
    # tlp = {
    #   enable = true;

    #   settings = {
    #     START_CHARGE_THRESH_BAT0 = 60;
    #     STOP_CHARGE_THRESH_BAT0 = 80;
    #   };
    # };
  };
}
