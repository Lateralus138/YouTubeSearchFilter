#!/usr/bin/env sh
chmod +x ./appimagetool-x86_64.AppImage
ARCH=x86_64 ./appimagetool-x86_64.AppImage appimage/ytsf.AppDir appimage/ytsf-x86_64.AppImage
