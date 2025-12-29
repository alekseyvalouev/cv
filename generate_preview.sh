#!/bin/bash

# Script to convert template.pdf to template.png with a white background

# Check if template.pdf exists
if [ ! -f "aleksey_valouev_cv.pdf" ]; then
    echo "Error: aleksey_valouev_cv.pdf not found."
    exit 1
fi

echo "Converting aleksey_valouev_cv.pdf to aleksey_valouev_cv.png with high quality..."

# We use qlmanage for high-quality PDF rendering (built-in on macOS)
# -t computes thumbnail, -s sets size (max dimension), -o sets output dir
qlmanage -t -s 2400 -o . aleksey_valouev_cv.pdf > /dev/null 2>&1

# qlmanage produces 'template.pdf.png'. We need to:
# 1. Strip the alpha channel to ensure a white background (via JPEG intermediate)
# 2. Rename it to 'template.png'
# Using formatOptions 100 for maximum JPEG quality
sips -s format jpeg -s formatOptions 100 aleksey_valouev_cv.pdf.png --out temp.jpg > /dev/null 2>&1
sips -s format png temp.jpg --out aleksey_valouev_cv.png > /dev/null 2>&1

# Cleanup
rm aleksey_valouev_cv.pdf.png
rm temp.jpg

if [ -f "aleksey_valouev_cv.png" ]; then
    echo "Success: aleksey_valouev_cv.png generated with white background."
else
    echo "Error: Failed to generate aleksey_valouev_cv.png."
    exit 1
fi
