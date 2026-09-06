{
  pkgs,
  inputs,
  ...
}:

{
  # Fixes packages relying on nix to use lix
  nixpkgs.overlays = [
    (final: prev: {
      inherit (prev.lixPackageSets.stable)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    })
  ];

  # Replaces nix with lix
  nix.package = pkgs.lixPackageSets.stable.lix;

  environment.systemPackages = with pkgs; [
    wget
    git
    dig
    nftables # Ability to interact with nftables firewall, reset rules with `nft flush ruleset`
    wireguard-tools
    jujutsu # Modern VCS compatible with git
    gitleaks # Check for any secrets being leaked
    gparted # NEEDS to be system package, run with `sudo -E gparted`
    pavucontrol # PulseAudio volume control
    pulseaudio
    #    networkmanagerapplet # Waybar networking control
    waypaper
    arrpc # Discord RPC server
    awww # Animated wallpaper daemon
    swaybg # Wallpaper tool
    gnome-themes-extra
    xwayland
    #    alvr
    ffmpeg
    mesa
    libva # VA-API implementation
    libva-utils
    playerctl # Media player control
    nix-your-shell # Allows `nix develop` to stay in user shell
    nh # Nix cli helper
    alejandra # Nix code formatter
    nil # Nix language server
    nixd # Another language server
    inputs.agenix.packages.${stdenv.hostPlatform.system}.default # Nix secrets management
    sops # Nix secrets management
    direnv # Shell extension managing environment variables
    base16-schemes # Themeing
    ddcutil
    localsend # AirDrop alternative
    # inputs.nixmate.packages.${stdenv.hostPlatform.system}.default # NixOS TUI helper
    inputs.hyprpolkitagent.packages.${stdenv.hostPlatform.system}.default
    libXtst
    inputs.lsfg-vk.packages.${stdenv.hostPlatform.system}.default # Lossless Scaling Frame Generation

    # Connect to iPhone over USB
    usbmuxd
    libimobiledevice
    ideviceinstaller

    # Local AI
    koboldcpp # AI
    # ollama-rocm # AI
    lmstudio # AI
    sillytavern # AI Frontend
  ];
}
