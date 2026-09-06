{
  ...
}:

{
  xdg.desktopEntries = {
    star-citizen = {
      name = "Star Citizen";
      exec = "gamescope -f -w 2560 -h 1440 -W 2560 -H 1440 --force-grab-cursor -- steam-run rsi-launcher %U";
      icon = "rsi-launcher";
      comment = "Roberts Space Industries Launcher for the game Star Citizen";
      terminal = false;
      categories = [ "Game" ];
    };
  };
}
