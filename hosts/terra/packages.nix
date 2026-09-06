{
  pkgs,
  inputs,
  self,
  ...
}:

let
  amethyst = pkgs.callPackage "${self}/pkgs/amethyst.nix" { };
  helium = pkgs.callPackage "${self}/pkgs/helium.nix" { };
  iloader = pkgs.callPackage "${self}/pkgs/iloader.nix" { };
  proton-drive-cli = pkgs.callPackage "${self}/pkgs/proton-drive-cli.nix" { };
in
with pkgs;
[
  # Applications
  protonplus
  lutris
  heroic
  # prismlauncher
  nautilus
  file-roller
  termius
  obsidian
  cider-2
  jan
  proton-pass

  # Gaming Utilities
  # wineWow64Packages.stable
  # wine
  # winetricks
  mono
  sc-controller
  amethyst # Linux modding client
  helium # Chromium-based browser
  minion # ESO modding tool

  # Games
  iw4x-launcher
  starsector
  # inputs.nix-gaming.packages.${stdenv.hostPlatform.system}.faf-client
  beyond-all-reason

  # CLI Games
  _2048-in-terminal
  vitetris
  nethack
  chess-tui # Needs a chess engine to accompany for computer games
  stockfish # Chess Engine

  # TUI
  btop
  amdgpu_top
  superfile # TUI file manager

  # Desktop
  nwg-look
  walker

  # Development
  exercism # learning tool
  rustup
  #  gleam
  #  ocaml
  #  clojure
  python3
  gcc
  gh
  nixfmt
  nixpkgs-fmt
  black
  iloader # tool to sideload .ipa  on apple devices

  # Utilities
  neovim
  jq
  socat
  tree
  tealdeer
  libnotify
  wl-clipboard
  wlsunset
  pywalfox-native
  imagemagick
  #  amdvlk
  rar
  unzip
  droidcam
  gpu-screen-recorder
  mpv
  cava
  lolcat # make terminal commands pretty
  cmatrix # fun matrix effect
  dysk # Better disk space analyzer
  solaar # control hardware devices
  evhz # measure mouse polling rates
  proton-drive-cli # Interact with Proton Drive

  # Charm apps (https://charm.land/apps)
  vhs # turn commands into gifs
  glow # TUI markdown reader

  # For SteamTinkerLaunch (install with protonplus)
  # xxd
  # xdotool
  # xwininfo
  # yad
  # steamtinkerlaunch

  # Niri
  xwayland-satellite
  wl-clipboard
]
