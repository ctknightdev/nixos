{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";
    nur.url = "github:nix-community/NUR";
    home-manager.url = "github:nix-community/home-manager";
    nixvim.url = "github:nix-community/nixvim";
    agenix.url = "github:ryantm/agenix";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    matcha = {
      url = "github:floatpane/matcha";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    matugen.url = "github:InioX/matugen";

    niri.url = "github:sodiboo/niri-flake";

    mcsr-nixos = {
      url = "https://git.uku3lig.net/uku/mcsr-nixos/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord.url = "github:4evy/nixcord";

    nixmate.url = "github:daskladas/nixmate";

    nixflix = {
      url = "github:kiriwalawren/nixflix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    moonlight = {
      url = "github:moonlight-mod/moonlight";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bakkesmod-nix.url = "github:AddG0/bakkesmod-nix";

    xremap-flake.url = "github:xremap/nix-flake";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    nix-gaming.url = "github:fufexan/nix-gaming";

    # Star Citizen
    nix-citizen.url = "github:LovingMelody/nix-citizen";

  };

  outputs =
    {
      self,
      nixpkgs,
      nix-citizen,
      ...
    }@inputs:
    {

      # Expose NixOS configuration
      nixosConfigurations.terra = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self inputs; };
        modules = [
          ./hosts/terra/configuration.nix
          inputs.stylix.nixosModules.stylix
          inputs.home-manager.nixosModules.default
          # inputs.agenix.nixosModules.default
          inputs.disko.nixosModules.disko

          nix-citizen.nixosModules.default
          {
            programs.rsi-launcher = {
              # Enables the star citizen module
              enable = true;
              umu.enable = true;
              gamescope = {
                enable = true;
                args = [
                  "-f"
                  "-w 2560"
                  "-h 1440"
                  "-W 2560"
                  "-H 1440"
                  "--force-grab-cursor"
                ];
              };

              # Additional commands before the game starts
              preCommands = ''
                export DXVK_HUD=compiler;
                export MANGOHUD=1;
              '';
              # # This option is enabled by default
              # #  Configures your system to meet some of the requirements to run star-citizen
              # # Set `vm.max_map_count` default to `16777216` (sysctl(8))
              # #Set `fs.file-max` default to `524288` (sysctl(8))
              # #Also sets `security.pam.loginLimits` to increase hard (limits.conf(5))
              # # Changes outlined in  https://github.com/starcitizen-lug/knowledge-base/wiki/Manual-Installation#prerequisites
              # setLimits = false;
            };
          }
        ];
      };
    };
}
