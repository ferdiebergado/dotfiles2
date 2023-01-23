#!/bin/bash
# Unregisters existing Wine file associations

rm -fv ~/.local/share/applications/wine-extension*.desktop
rm -fv ~/.local/share/icons/hicolor/*/*/application-x-wine-extension*
rm -fv ~/.local/share/applications/mimeinfo.cache
rm -fv ~/.local/share/mime/packages/x-wine*
rm -fv ~/.local/share/mime/application/x-wine-extension*

update-desktop-database ~/.local/share/applications
update-mime-database ~/.local/share/mime/
