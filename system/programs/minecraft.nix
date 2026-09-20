{
  pkgs,
  ...
}:
# let
#   mcsrPkgs = inputs.mcsr-nixos.packages.${pkgs.stdenv.hostPlatform.system};
# in
{
  imports = [ ./mcsr ];

  systemd.tmpfiles.rules = [
    "L+ /opt/temurin-25 - - - - ${pkgs.temurin-bin-25}"
    "L+ /opt/temurin-21 - - - - ${pkgs.temurin-bin-21}"
    "L+ /opt/temurin-17 - - - - ${pkgs.temurin-bin-17}"
    "L+ /opt/temurin-8 - - - - ${pkgs.temurin-bin-8}"
  ];

  environment.systemPackages = [
    # mcsrPkgs.ninjabrain-bot

    pkgs.lunar-client

    (pkgs.prismlauncher.override {
      additionalLibs = [
        pkgs.jemalloc
        pkgs.libxtst
        pkgs.libxkbcommon
        pkgs.libxt
        pkgs.libxinerama
        pkgs.glfw3-minecraft
      ];

      jdks = [
        # programs/java.nix
        # avoids having to re-detect nix store paths every time
        "/opt/temurin-25"
        "/opt/temurin-21"
        "/opt/temurin-17"
        "/opt/temurin-8"
      ];
    })

  ];
}
