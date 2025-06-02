#!/bin/bash

THEMES_DIR="$HOME/.config/themes"
WAYBAR_CONFIG="$HOME/.config/waybar"
HYPR_CONFIG_DIR="$HOME/.config/hypr"
WALLPAPER_SCRIPT="$HOME/.config/hypr/scripts/wallpaper-switcher.sh"
WALLPAPER_DIR_FILE="$HOME/.config/hypr/wallpaper_dir.conf"
HYPR_THEME_FILE="$HYPR_CONFIG_DIR/hypr.theme"
KITTY_CONFIG="$HOME/.config/kitty/kitty.conf"

THEMES=($(ls "$THEMES_DIR"))
THEME=$(printf "%s\n" "${THEMES[@]}" | rofi -dmenu -p 'Select a theme:')

# no theme was selected, exit the script
if [[ -z "$THEME" ]]; then
    echo "No theme selected, exiting."
    exit 1
fi

if [[ ! -d "$THEMES_DIR/$THEME" ]]; then
    echo "Theme '$THEME' does not exist!"
    exit 1
fi

# apply the theme to Waybar
cp "$THEMES_DIR/$THEME/theme.css" "$WAYBAR_CONFIG/theme.css"

# apply the theme to the Hyprland config
if [[ -f "$THEMES_DIR/$THEME/hypr.theme" ]]; then
    cp "$THEMES_DIR/$THEME/hypr.theme" "$HYPR_THEME_FILE"
else
    echo "Warning: No hypr.theme found for '$THEME'. Keeping existing configuration."
fi

if [[ -f "$THEMES_DIR/$THEME/kitty.conf" ]]; then
    BG_COLOR=$(grep '^background' "$THEMES_DIR/$THEME/kitty.conf" | awk '{print $2}')
    FG_COLOR=$(grep '^foreground' "$THEMES_DIR/$THEME/kitty.conf" | awk '{print $2}')
    
    if [[ -n "$BG_COLOR" && -n "$FG_COLOR" ]]; then
        sed -i "s/^background .*/background $BG_COLOR/" "$KITTY_CONFIG"
        sed -i "s/^foreground .*/foreground $FG_COLOR/" "$KITTY_CONFIG"
        
        pkill -USR1 kitty
    else
        echo "Warning: Invalid or missing colors in $THEMES_DIR/$THEME/kitty.conf"
    fi
else
    echo "Warning: No kitty.conf found for '$THEME'. Keeping existing configuration."
fi

# restart Waybar
pkill waybar && waybar &

# saves the wallpaper directory for the selected theme
export WALLPAPER_DIR="$THEMES_DIR/$THEME/wallpapers"
echo "$WALLPAPER_DIR" > "$WALLPAPER_DIR_FILE"

hyprctl reload

# runs the wallpaper switcher script
"$WALLPAPER_SCRIPT"
