ICON_FILE=${HOME}/.local/share/applications/prusa-slicer.png
DESKTOP_FILE=${HOME}/.local/share/applications/prusa-slicer.desktop
APPIMAGE=${HOME}/bin/prusa-slicer.AppImage
APPIMAGE_ZIP=${HOME}/bin/prusa-slicer.zip

default: install

cache:
	mkdir "$@"

#  Icon file
# ===========
${ICON_FILE}: cache/squashfs-root/PrusaSlicer.png
	cp "$^" "$@"
	chmod 0600 "$@"
	rm -rf "cache/squashfs-root"

cache/squashfs-root/PrusaSlicer.png: cache/prusa-slicer.AppImage
	cd cache && ./prusa-slicer.AppImage --appimage-extract

#  Desktop file
# ==============
cache/prusa-slicer.desktop:
	./create_desktop.sh "$@"

${DESKTOP_FILE}: cache/prusa-slicer.desktop
	cp "$^" "$@"
	chmod 0600 "$@"

#  AppImage
# ==========
.INTERMEDIATE: cache/prusa-slicer.zip
cache/prusa-slicer.zip: | cache
	./download_slicer.sh "$@"

.INTERMEDIATE: cache/prusa-slicer.AppImage
cache/prusa-slicer.AppImage: cache/prusa-slicer.zip
	unzip -n "$^" -d "./cache"
	cp "$(wildcard ./cache/*.AppImage)" "$@"
	chmod +x "$@"

${APPIMAGE}: cache/prusa-slicer.AppImage
	cp "$^" "$@"

#  Utils
# =======
.PHONY: list
list:
	ls -lah "${HOME}/.local/share/applications/"

#  Install target
# =================
install: ${APPIMAGE} ${ICON_FILE} ${DESKTOP_FILE}

#  Uninstall target
# ==================
uninstall:
	rm ${APPIMAGE}
	rm ${ICON_FILE}
	rm ${DESKTOP_FILE}
