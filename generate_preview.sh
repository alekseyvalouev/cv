#!/bin/bash

# Script to convert template.pdf to template.png with a white background

# Check if template.pdf exists
if [ ! -f "template.pdf" ]; then
    echo "Error: template.pdf not found."
    exit 1
fi

echo "Converting template.pdf to template.png with high quality..."

# We use qlmanage for high-quality PDF rendering (built-in on macOS)
# -t computes thumbnail, -s sets size (max dimension), -o sets output dir
qlmanage -t -s 2048 -o . template.pdf > /dev/null 2>&1

# qlmanage produces 'template.pdf.png'. We need to:
# 1. Strip the alpha channel to ensure a white background (via JPEG intermediate)
# 2. Rename it to 'template.png'
sips -s format jpeg template.pdf.png --out temp.jpg > /dev/null 2>&1
sips -s format png temp.jpg --out template.png > /dev/null 2>&1

# Cleanup
rm template.pdf.png
rm temp.jpg

if [ -f "template.png" ]; then
    echo "Success: template.png generated with white background."
else
    echo "Error: Failed to generate template.png."
    exit 1
fi
