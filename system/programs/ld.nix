{
  pkgs,
  inputs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    inputs.nix-alien.packages.${stdenv.hostPlatform.system}.nix-alien
  ];

  programs.nix-ld = {
    enable = true;

    # libraries = pkgs.steam-run.fhsenv.args.multiPkgs pkgs;
    # ^ this doesn't work the list here is weird
    # based on LSB 5.0
    # reference: http://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Common/LSB-Common/requirements.html#RLIBRARIES
    libraries = with pkgs;  [
      # Core
      glibc
      gcc.cc
      stdenv.cc.cc.lib
      zlib
      ncurses5
      linux-pam
      nspr
      nspr
      nss
      openssl

      # Runtime Languages
      libxml2
      libxslt

      # Bonus (not in LSB)
      bzip2
      curl
      expat
      libusb1
      libcap
      dbus
      libuuid


      # Desktop

      ## Graphics Libraries (X11)
      libx11
      libxcb
      libsm
      libice
      libxt
      libxft
      libxrender
      libxext
      libxi
      libxtst
      libxcursor
      libxcomposite
      libxfixes
      libxdamage
      libxrandr
      libxscrnsaver
      libxfixes
      libxkbcommon

      ## OpenGL Libraries
      libGL
      libGLU

      ## Misc. desktop
      libpng12
      libjpeg
      fontconfig
      freetype
      libtiff
      cairo
      pango
      atk

      ## GTK+ Stack Libraries
      gtk2
      gdk-pixbuf
      glib
      dbus-glib
      at-spi2-core
      at-spi2-atk

      ## Sound libraries
      alsa-lib
      openal

      ## SDL
      SDL
      SDL_image
      SDL_mixer
      SDL_ttf
      SDL2
      SDL2_image
      SDL2_mixer
      SDL2_ttf

      # Imaging
      cups
      sane-backends

      # Trial Use
      libpng
      gtk3

    ];
  };
  services = {
    envfs = {
      enable = true;
    };
  };
}
