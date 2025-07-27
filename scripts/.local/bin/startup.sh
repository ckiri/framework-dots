#! /bin/sh
#
# Start applications for niri

# The video output configuration daemon
kanshi >/dev/null 2>&1 & 
# Run X11 applications
xwayland-satellite >/dev/null 2>&1 & 
# Check if device has a battery, if true, start a battery daemon
if test -d /sys/class/power_supply/BAT1
then
    $HOME/.local/bin/batterystate.sh >/dev/null 2>&1 &
fi
# Enable eyesaving mode
gammastep -l 49.0:9.2 -t 5700:3600 -b 1:0.75 >/dev/null 2>&1 &
# Set theme for apps
dconf write /org/gnome/desktop/interface/color-scheme '"prefer-light"' >/dev/null 2>&1 & 
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3' >/dev/null 2>&1 & 
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Light' >/dev/null 2>&1 &
# Start the idle daemon
swayidle -w \
    timeout 900 'brightnessctl --save && brightnessctl set 1%' resume 'brightnessctl --restore' \
    timeout 1200 'swaylock -f' \
    timeout 1260 'niri msg output off \*' resume 'niri msg output on \*' \
    timeout 1800 'systemctl suspend-then-hiberante' \
    before-sleep 'swaylock -f' >/dev/null 2>&1
# DBus activation (Needed for keyring callbacks)
dbus-update-activation-environment \
    --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP >/dev/null 2>&1 & 
