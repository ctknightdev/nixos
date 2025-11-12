![NixOS Configuration](https://i.imgur.com/GWQyNWb.jpeg)

Click on the image to see the demo.

> ⚠️ **Important:** This repository includes my personal `hardware-configuration.nix`, which is specific to my hardware setup.
> You **must replace it** with one generated for your system using `nixos-generate-config` to avoid compatibility issues.

# NixOS Configuration

This repository contains my personal NixOS configuration for a customized desktop and development environment. 🎨💻

## Directory Structure

- **`assets/`** 🎨
  Contains custom icons and wallpapers.

  - **`icons/`**: Custom icon set.
  - **`wallpapers/`**: Collection of wallpapers.

- **`hosts/`** 🖥️
  Host-specific configurations.

- **`home/`** 🏠
  Home Manager modules for niri, editors, browsers, and more.
  - **`niri/`**: Configuration for niri and related tools.
  - **`programs/editors/`**: Helix, VSCode, Zed, etc. configurations.
  - **`programs/browsers`**: Firefox, chromium, zen, vivaldi, etc. configurations.
  - **`programs/gamedev`**: Godot, Unity configurations.
  - **`programs/terminal`**: Zoxide configurations.
  - **`programs/`**: Other misc. configurations (Discord, fastfetch, ghostty, mangohud, etc.).

- **`pkgs/`** 📦
  Custom packages not in nixpkgs or flakes
  - **`jackify.nix`**: Mod manager that uses Wabbjack modlists and downloads from Nexus

- **`scripts/`** ⚙️
  Custom scripts to make system management a little easier
  - **`disable_usb_wakeup.sh`**: Disables a few annoying USB devices from waking the computer from suspend
  - **`eso-trade-update.sh`**: Updates pricing data for add-ons in the game Elder Scrolls Online
  - **`fetch-addon.sh`**: Gets extension IDs for Firefox given the extension's URL
  - **`proton-wine.sh`**: Fixes a rarely reoccuring issue where Proton and Wine would disagree
  - **`rdo-private.sh`**: Manages firewall rules in order to force a private lobby in Red Dead Online (occassionally breaks)
  - **`restart-noctalia.sh`**: Restarts the Noctalia Shell process, commonly needed after updating flakes and packages


- **`system/`** 🔧
  System-wide configurations.
  - **`greeter/`**: Greetd configuration for login.
  - **`programs/`**: System wide program configurations (Steam, nix-ld, stylix, etc.).
  - **`services/`**: System wide program configurations (ssh, tailscale, docker, flatpak, \*arr, sops, etc.).
  - **`shell/`**: Shell configurations for zsh
  - **`environment.nix`**: Global environment settings.
  - **`packages.nix`**: System wide package installations.
  - **`xdg.nix`**: XDG settings.

## Getting Started

Clone this repository and adjust the configurations based on your system. Modify the host-specific files and modules to suit your needs.

Don't forget to change usernames and secrets management if applicable

Feel free to customize and contribute!

## See Also
* [NixOS](https://nixos.org/): The declaritive operating system used to make this all possible
* [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/introduction/): Incredible written learning resource for getting started
* [Vimjoyer](https://www.youtube.com/@vimjoyer): Video resources for getting started with Nix concepts
* [Niri](https://github.com/YaLTeR/niri): Window manager used for this setup. Offers infinite horizontal scrolling
* [Noctalia-shell](https://github.com/noctalia-dev/noctalia-shell): Incredible desktop shell built on Quickshell. Provides too much functionality to list
* [Catppuccin](https://catppuccin.com/): Lovely theme for nearly any application at this point. Allows for cohesive and cozy styling
