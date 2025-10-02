#!/bin/sh
#
# Open PDFs using zathura

file=$(find ~/docs -name "*.pdf" | wmenu -l 20 -f "Sans-serif Regular 10") 
test -z "$file" && exit 1
zathura "$file"
