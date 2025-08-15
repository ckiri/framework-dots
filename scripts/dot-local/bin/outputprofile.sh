#! /bin/sh
# 
# Switch output profiles using kanshi with dmenu

choice=$(wmenu -p "Switch output to:" -l 2 <<< "mirror
extend
")

test ! -z $choice && kanshictl switch $choice
