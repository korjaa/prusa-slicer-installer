#!/bin/bash

# Get destination file name
OUTPUT="$1"
if [ -z "$OUTPUT" ]; then
	echo "No output file defined"
	exit 1
fi

# Get link
URL="$(curl --location --silent "https://www.prusa3d.com/prusaslicer/" | grep -Po '(?<=href=")https://www.prusa3d.com/downloads/drivers/prusa3d_linux_[0-9_]*.zip')"
if [ -z "$URL" ]; then
	echo "Failed to get slicer link"
	exit 1
fi

# Download
curl --location "$URL" --output "$OUTPUT"
