#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

if [ ! -d "$WALLPAPER_DIR" ]; then
  echo "Error: Wallpaper directory '$WALLPAPER_DIR' not found."
  echo "Please correct WALLPAPER_DIR in the script."
  exit 1
fi

if ! pgrep -x "swww-daemon" >/dev/null; then
  echo "swww-daemon not running. Starting..."
  swww-daemon &
  sleep 0.5
  echo "swww-daemon started."
fi

WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.bmp" \) | shuf -n 1)

if [ -z "$WALLPAPER" ]; then
  echo "No supported image files found in '$WALLPAPER_DIR'."
  exit 1
fi

echo "Setting wallpaper: $WALLPAPER"
if ! pgrep -x "swww-daemon" >/dev/null; then
  sleep 0.5
fi

swww img "$WALLPAPER" --transition-fps 100 --transition-type outer --transition-step 30

echo "Wallpaper changed successfully!"
