{
  config,
  pkgs,
  ...
}:

let
  apps = import ./applications.nix { inherit pkgs; };

  # Run `noctalia msg --help` to see available commands, use `less` to search output
  noctalia =
    cmd:
    [
      "noctalia"
      "msg"
    ]
    ++ (pkgs.lib.splitString " " cmd);
in
{
  programs.niri.settings.binds = with config.lib.niri.actions; {
    # Prevent programs from blocking key presses
    "Mod+Escape".action.toggle-keyboard-shortcuts-inhibit = [ ];

    # Turn off all displays
    "Mod+Shift+P".action.power-off-monitors = [ ];

    # Quit Niri
    "Control+Alt+Delete".action.quit = [ ];

    # Volume
    "XF86AudioRaiseVolume".action.spawn = noctalia "volume-up"; # output increase
    "XF86AudioLowerVolume".action.spawn = noctalia "volume-down"; # output decrease
    "XF86AudioMute".action.spawn = noctalia "volume-mute"; # output mute
    "Shift+XF86AudioRaiseVolume".action.spawn = noctalia "mic-volume-up"; # input increase
    "Shift+XF86AudioLowerVolume".action.spawn = noctalia "mic-volume-down"; # input decrease
    "Shift+XF86AudioMute".action.spawn = noctalia "mic-volume-mute"; # input mute
    "Mod+W".action.spawn = noctalia "mic-volume-mute"; # input mute alternate
    "Control+XF86AudioMute".action.spawn = noctalia "panel-toggle control-center audio"; # open volume panel

    # Media
    "XF86AudioPlay".action.spawn = noctalia "media toggle";
    "XF86AudioNext".action.spawn = noctalia "media next";
    "XF86AudioPrev".action.spawn = noctalia "media previous";

    "Mod+Space".action.spawn = noctalia "panel-toggle launcher";
    "Mod+Q".action = close-window;
    "Mod+B".action = spawn apps.browser;
    "Mod+Return".action = spawn apps.terminal;
    #    "Mod+Space".action = spawn apps.appLauncher;
    "Mod+E".action = spawn apps.fileManager;
    "Mod+L".action.spawn = noctalia "session lock";

    # Tested with ghostty and kitty
    # "Mod+M".action = spawn apps.terminal [
    #   "--title=spotify_player"
    #   "-e"
    #   "spotify_player"
    # ];

    # 1Passord quick access
    "Mod+p".action = spawn [
      "${pkgs._1password-gui}/bin/1password"
      "--quick-access"
    ];

    "Mod+F".action = fullscreen-window;
    "Mod+T".action = toggle-window-floating;

    "Control+Shift+1".action.screenshot = [ ];
    "Control+Shift+2".action.screenshot-window = [ ];

    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;
    "Mod+Down".action = focus-workspace-down;
    "Mod+Up".action = focus-workspace-up;

    "Mod+Shift+Left".action = move-column-left;
    "Mod+Shift+Right".action = move-column-right;
    "Mod+Shift+Down".action = move-column-to-workspace-down;
    "Mod+Shift+Up".action = move-column-to-workspace-up;

    "Mod+1".action = focus-workspace "main";
    "Mod+2".action = focus-workspace "browser";
    "Mod+3".action = focus-workspace "discord";
    "Mod+4".action = focus-workspace "music";
  };
}
