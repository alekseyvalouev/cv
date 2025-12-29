#!/bin/bash

# Script to convert template.pdf to template.png with a white background

# Check if template.pdf exists
if [ ! -f "template.pdf" ]; then
    echo "Error: template.pdf not found."
    exit 1
fi

echo "Converting template.pdf to template.png..."

# We use a JPEG intermediate to easily strip the alpha channel and ensure a white background
# using sips (built-in on macOS)
sips -s format jpeg template.pdf --out temp.jpg > /dev/null 2>&1
sips -s format png temp.jpg --out template.png > /dev/null 2>&1
rm temp.jpg

if [ -f "template.png" ]; then
    echo "Success: template.png generated with white background."
else
    echo "Error: Failed to generate template.png."
    exit 1
fi
