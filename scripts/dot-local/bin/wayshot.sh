#!/bin/sh
#
# Take screenshots on wayland

OUTPUT_PREFIX="$(xdg-user-dir PICTURES)/screenshots/"

# Create output folder if it doesn't exist
test ! -d $OUTPUT_PREFIX && mkdir -p $OUTPUT_PREFIX

# Take the screenshot, save to a file & copy to clipboard
shoot() {
    # Get current date and time
    timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

    # Name screenshot
    input=$(printf "\n" | wmenu -S "#222222" -p "Enter a filename:")
    test -n "$input" && filename="${OUTPUT_PREFIX}${input}.png"
    # Take timesramp if input/name is empty
    test ! -n "$input" && filename="${OUTPUT_PREFIX}${timestamp}.png"

    # Save screenshot to file & copy to clipboard
    grim -g "$(slurp)" - | wl-copy --type image/png
    test ! -n "$filename" && exit 1
    wl-paste > $filename
}

shoot
