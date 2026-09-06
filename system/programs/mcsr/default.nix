{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  cfg = config.programs.waywall;
  mcsrPkgs = inputs.mcsr-nixos.packages.${pkgs.stdenv.hostPlatform.system};

  thin = pkgs.fetchurl {
    url = "https://v.uku.moe/u/thin.png";
    hash = "sha256-VzT9a0/+JMG+To80+xuQSo4x2w6+zavCvUJ6irBkpVg=";
  };

  wide = pkgs.fetchurl {
    url = "https://v.uku.moe/u/wide.png";
    hash = "sha256-xJX+QladHQiQYBdKZEB9kuEaxBWVZuuStf4r4gIv5uo=";
  };

  tall = pkgs.fetchurl {
    url = "https://v.uku.moe/u/tall.png";
    hash = "sha256-RLyV6iFVDlJKKEdA3CBAQR/sIj2WnhZVBAmLzVmS7JA=";
  };
in
{
  imports = [ inputs.mcsr-nixos.nixosModules.waywall ];

  options = {
    programs.waywall = {
      width = lib.mkOption {
        type = lib.types.int;
        default = 2560;
      };

      height = lib.mkOption {
        type = lib.types.int;
        default = 1440;
      };
    };
  };

  config = {
    hj.".config/waywall/init.lua".source = config.programs.waywall.config.finalFile;

    programs.waywall = {
      enable = true;
      config = {
        enableWaywork = true;
        programs = [ mcsrPkgs.ninjabrain-bot ];
        files = {
          eye_overlay = ./eye-overlay.png;
          inherit thin wide tall;
        };

        text = ''
          local resolution = { w = ${toString cfg.width}, h = ${toString cfg.height} }
        ''
        + builtins.readFile ./waywall.lua;

        linkWithSystemd = false;
      };
    };
  };
}
