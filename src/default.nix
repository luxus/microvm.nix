{
  documentation = {
    doc.enable = false;
    info.enable = false;
    nixos.enable = false;
  };
  security.sudo.wheelNeedsPassword = false;

  system = {
    autoUpgrade = {
      enable = false;
      dates = "04:00";
    };
    stateVersion = "22.11";
  };

  time.timeZone = "Europe/Zurich";
}
