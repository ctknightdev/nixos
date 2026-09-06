{
  lib,
  pkgs,
  stdenvNoCC,
  bun,
  fetchFromGitHub,
  makeWrapper,
  writableTmpDirAsHomeHook,
  xdg-utils,
}:

let
  secretsLibs = with pkgs; [
    libsecret
    glib
    pcre2
    libffi
    libselinux
    libgpg-error
    util-linux.lib
    libgcrypt.lib
  ];
in

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "proton-drive-cli";
  version = "0.4.2";

  strictDeps = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "ProtonDriveApps";
    repo = "sdk";
    rev = "61a70d4b6e5ccd6a1634bda87335d7a17f5a7d13";
    hash = "sha256-osL19KAnKL+Qbl78YrPwE9Y8LPchZN1Mo7WbU+MjlRk=";
  };

  sourceRoot = "${finalAttrs.src.name}/js/cli";

  node_modules = stdenvNoCC.mkDerivation {
    pname = "${finalAttrs.pname}-node_modules";
    inherit (finalAttrs) version src sourceRoot;

    strictDeps = true;
    __structuredAttrs = true;

    nativeBuildInputs = [
      bun
      writableTmpDirAsHomeHook
    ];

    dontConfigure = true;

    buildPhase = ''
      runHook preBuild

      export BUN_INSTALL_CACHE_DIR=$(mktemp -d)
      bun install \
        --cpu="*" \
        --frozen-lockfile \
        --ignore-scripts \
        --no-progress \
        --os="*"

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out
      cp -R node_modules $out/

      runHook postInstall
    '';

    dontFixup = true;

    outputHash = "sha256-8F1wphESKqr9s00BPH6gClkxsOuuMQBpRsL8yx+FHms=";
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
  };

  nativeBuildInputs = [
    bun
    makeWrapper
  ];

  configurePhase = ''
    runHook preConfigure

    # Upstream uses a sibling workspace dependency via `file:../sdk`,
    # so both the CLI tree and sibling SDK tree need vendored node_modules.
    chmod -R u+w ../sdk
    cp -R ${finalAttrs.node_modules}/node_modules .
    cp -R ${finalAttrs.node_modules}/node_modules ../sdk/

    runHook postConfigure
  '';

  env.CLI_VERSION = finalAttrs.version;
  env.JS_VERSION = "0.16.0";
  env.CLI_APP_VERSION_NAME = "external-drive-proton_drive_cli";

  buildPhase = ''
    runHook preBuild

    bun run build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 release/proton-drive $out/bin/proton-drive
        wrapProgram $out/bin/proton-drive \
          --suffix LD_LIBRARY_PATH : "${lib.makeLibraryPath secretsLibs}" \
          --suffix PATH : ${lib.makeBinPath [ xdg-utils ]}

    runHook postInstall
  '';

  dontStrip = true;

  nativeInstallCheckInputs = [ writableTmpDirAsHomeHook ];
  doInstallCheck = true;
  installCheckPhase = ''
    runHook preInstallCheck

    # Bun.secrets and XDG path resolution expect a writable HOME during checks.
    PROTON_DRIVE_UNSAFE_SECRETS=1 $out/bin/proton-drive version | grep -F "external-drive-proton_drive_cli@${finalAttrs.version}"
    PROTON_DRIVE_UNSAFE_SECRETS=1 $out/bin/proton-drive help > /dev/null

    runHook postInstallCheck
  '';

  meta = {
    description = "Command-line interface for Proton Drive";
    homepage = "https://github.com/ProtonDriveApps/sdk/tree/${finalAttrs.src.rev}/js/cli";
    changelog = "https://github.com/ProtonDriveApps/sdk/blob/${finalAttrs.src.rev}/js/cli/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ cameroncandau ];
    mainProgram = "proton-drive";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [
      fromSource
      binaryNativeCode
    ];
  };
})
