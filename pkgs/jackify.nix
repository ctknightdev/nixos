{
  appimageTools,
  fetchurl,
  lib,
}:

let
  version = "0.1.7.1";
  pname = "Jackify";
  id = "com.jackify.app";

  src = fetchurl {
    url = "https://github.com/Omni-guides/Jackify/releases/download/v${version}/${pname}.AppImage";
    hash = "sha256:1cca37226fb96790ab14078d1aacd4b7e264addd9cd22ec19d386a927610e2f5";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs =
    pkgs:
    (with pkgs; [
      icu
      zstd
    ]);

  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/${id}.desktop -t $out/share/applications
    install -Dm444 ${appimageContents}/${id}.png -t $out/share/pixmaps
  '';

  meta = {
    description = "A modlist installation and configuration tool for Wabbajack modlists on Linux";
    homepage = "https://github.com/Omni-guides/Jackify";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ legit228 ];
    platforms = lib.platforms.linux;
  };
}
