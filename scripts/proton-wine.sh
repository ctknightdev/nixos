#!/usr/bin/env bash

# Usage Example
# proton-wine /games/SteamLibrary/steamapps/compatdata/489830/pfx \
#   /home/chris/.cache/winetricks/vcrun2022/vc_redist.x64.exe /quiet /norestart


PROTON_DIR="$HOME/.steam/root/compatibilitytools.d/GE-Proton10-21"
PREFIX="$1"; shift
steam-run "$PROTON_DIR/files/bin/wine64" "$@"

