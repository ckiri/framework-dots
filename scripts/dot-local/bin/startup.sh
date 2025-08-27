#!/bin/sh

~/.local/bin/batterystate.sh 2>&1 &

swayidle -w \
    timeout 900 'brightnessctl --save && brightnessctl set 1%' resume 'brightnessctl --restore' \
    timeout 1200 'swaylock -f' \
    timeout 1260 'niri msg output eDP-1 off' resume 'niri msg output eDP-1 on' \
    timeout 1800 'systemctl suspend' \
    before-sleep 'swaylock -f' >/dev/null 2>&1 &

dconf write /org/gnome/desktop/interface/color-scheme '"prefer-light"' 2>&1 &
gsettings set org.gnome.desktop.interface gtk-theme 'HighContrast' 2>&1 &
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Light' 2>&1 &

gammastep -l 49.0:9.2 -t 5700:3600 >/dev/null 2>&1 &

exec dbus-update-activation-environment \
    --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP >/dev/null 2>&1
