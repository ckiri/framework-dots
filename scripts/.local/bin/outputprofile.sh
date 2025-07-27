#! /bin/sh
# 
# Switch output profiles using kanshi with dmenu

choice=$(wmenu -p "Switch output to:" -l 7 <<< "mirror
extend
home-external-only
home-extend
")

[[ ! -z $choice ]] && kanshictl switch $choice
