#!/usr/bin/env zsh
##

url="$1"
title="$2"
description="$3"
feed_title="$4"

#echo -e "${url}\t${title}\t${description}\t${feed_title}" >> ~/bookmarks.txt

if [[ "$url" == *"i.redd"* || "$url" == *"imgur"* ]]; then
  wget --output-document /tmp/feh "$url"
  convert /tmp/feh -background black -fill white -font Source-Code-Pro-Bold -pointsize 35 label:"$title" -gravity Center -append /tmp/feh_title
  feh --scale-down --recursive /tmp/feh_title && /bin/rm /tmp/feh /tmp/feh_title
elif [[ "$url" == *"v.red"* || "$url" == *"streama"* ]]; then
  mpv --pause --quiet "$url"
else
  "$HOME/git/scripts/shell/rofi_openwith" "$url"
fi
