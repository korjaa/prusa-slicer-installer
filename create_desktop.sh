#!/bin/bash

# Get destination file name
OUTPUT="$1"
if [ -z "$OUTPUT" ]; then
	echo "No output file defined"
	exit 1
fi

cat <<-EOF > "$OUTPUT"
	#!/usr/bin/env xdg-open
	[Desktop Entry]
	Name=Prusa Slicer
	Exec=${HOME}/bin/prusa-slicer.AppImage
	Icon=${HOME}/.local/share/applications/prusa-slicer.png
	Type=Application
	Categories=3DGraphics
	MimeType=application/x-iso9660-appimage;
EOF
