#!/bin/bash

WALLPAPER_DIR_FILE="$HOME/.config/hypr/wallpaper_dir.conf"
LAST_WALLPAPER_FILE="$HOME/.config/hypr/last_wallpaper.conf"

if [[ -f "$WALLPAPER_DIR_FILE" ]]; then
    WALLPAPER_DIR=$(cat "$WALLPAPER_DIR_FILE")
else
    echo "Error: No wallpaper directory found!"
    exit 1
fi

echo "A: $WALLPAPER_DIR"
DIR="$WALLPAPER_DIR"

echo "Detected theme: $CURRENT_THEME"

if [[ ! -d "$DIR" || -z "$(ls -A "$DIR" 2>/dev/null)" ]]; then
    echo "Warning: No wallpapers found for theme '$CURRENT_THEME'. Using default."
    DIR="$HOME/.config/hypr/wallpapers"
fi

FPS=60
TYPE="grow"
DURATION=1

POS=$(hyprctl cursorpos | tr -d ' ')  
SWWW_PARAMS="--transition-bezier .43,1.19,1,.4 --transition-type $TYPE --transition-duration $DURATION --transition-fps $FPS --invert-y --transition-pos $POS"

PICS=($(ls "${DIR}" | grep -E "\.(jpg|jpeg|png|gif)$"))

RANDOM_PIC=${PICS[ $RANDOM % ${#PICS[@]} ]}
RANDOM_PIC_NAME="${#PICS[@]}. random"

if [[ $(pidof swaybg) ]]; then
  pkill swaybg
fi

rofi_command="rofi -dmenu -p 'Choose wallpaper:'"

menu(){
    for i in ${!PICS[@]}; do
        if [[ -z $(echo "${PICS[$i]}" | grep ".gif$") ]]; then
            printf "$i. $(echo "${PICS[$i]}" | cut -d. -f1)\n"
        else
            printf "$i. ${PICS[$i]}\n"
        fi
    done
    printf "$RANDOM_PIC_NAME"
}

swww query || swww-daemon

main() {
    choice=$(menu | ${rofi_command})

    if [[ -z $choice ]]; then return; fi

    if [ "$choice" = "$RANDOM_PIC_NAME" ]; then
        echo "${DIR}/${RANDOM_PIC}" > "$LAST_WALLPAPER_FILE"
        swww img "${DIR}/${RANDOM_PIC}" $SWWW_PARAMS
        return
    fi
    
    pic_index=$(echo $choice | cut -d. -f1)
    echo "${DIR}/${PICS[$pic_index]}" > "$LAST_WALLPAPER_FILE"
    swww img "${DIR}/${PICS[$pic_index]}" $SWWW_PARAMS
}

if pidof rofi >/dev/null; then
    killall rofi
    exit 0
else
    main
fi
