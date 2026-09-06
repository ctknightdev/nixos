{
  pkgs,
  ...
}:

{
  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    package =
      with pkgs;
      steam.override {
        extraPkgs = pkgs: [
          gamemode

          # Extra packages added for FAF - Forged Alliance Forever
          jq
          cabextract
          wget
          pkgsi686Linux.libpulseaudio
          pkgsi686Linux.freetype
          pkgsi686Linux.libXcursor
          pkgsi686Linux.libXcomposite
          pkgsi686Linux.libXi
        ];
      };
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
    protontricks.enable = true;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = false;
    args = [
      "--rt"
      "--expose-wayland"
    ];
  };

  programs.gamemode.enable = true;

  # OpenGL and Vulkan configuration
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    vulkan-loader
    vulkan-tools
  ];

  environment.systemPackages = with pkgs; [
    libusb1 # Used for VR devices
    usbutils
    libsndfile
    xwayland
    gamescope

    wineWow64Packages.stagingFull
    winetricks
    freetype
    fontconfig
    zenity

    # Elite Dangerous
    min-ed-launcher # launcher
    edhm-ui # ui mod
  ];

  # To connect controller (and reconnect automatically)
  # 1. `bluetoothctl`
  # 2. `pairable on`
  # 3. `agent on`
  # 4. `default-agent`
  # 5. `scan on`
  # 6. `pair <Controller MAC>`
  # 7. `trust <Controller MAC>`
  # 8. `connect <Controller MAC>`
  services.udev.extraRules = ''
    # 8BitDo Ultimate 2 Wireless; 2.4GHz/Dongle; Bluetooth
    KERNEL=="hidraw*", ATTRS{idProduct}=="6012", ATTRS{idVendor}=="2dc8", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", KERNELS=="*2DC8:6012*", MODE="0660", TAG+="uaccess"

    # Sony PlayStation DualShock 4; Bluetooth; USB
    ACTION!="remove", KERNEL=="hidraw*", KERNELS=="*054C:05C4*", MODE="0660", TAG+="uaccess"
    ACTION!="remove", KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0660", TAG+="uaccess"

    # Sony PlayStation DualShock 4 Slim; Bluetooth; USB
    ACTION!="remove", KERNEL=="hidraw*", KERNELS=="*054C:09CC*", MODE="0660", TAG+="uaccess"
    ACTION!="remove", KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0660", TAG+="uaccess"

    # Enable uinput device permissions
    KERNEL=="uinput", MODE="0660", GROUP="input", TAG+="uaccess"
  '';
}
