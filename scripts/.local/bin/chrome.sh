#/bin/sh
#
# Start the chromium webbrowser with wayland flags for right scaling

chromium \
    --enable-features=UseOzonePlatform \
    --ozone-platform=wayland
