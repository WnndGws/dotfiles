#!/usr/bin/env zsh
## Use zsh so can use bash-isms
## Feed this script a link and it will give rofi a list of link_handlers to open with

url="$1"
title="$2"
description="$3"
feed_title="$4"

if [[ "${#url}" -gt 30 ]];
then
    visual="${url:0:20}"..."${url: -7}"
else
    visual="$url"
fi

open_images() {
  wget --output-document /tmp/feh "$url"
  convert /tmp/feh -background black -fill white -font Source-Code-Pro-Bold -pointsize 35 label:"$title" -gravity Center -append /tmp/feh_title
  feh --scale-down --recursive /tmp/feh_title && /bin/rm /tmp/feh /tmp/feh_title
}

get_paragraph() {
  /bin/rm /tmp/para.txt
  "$HOME/git/scripts/python/paragraphscraper/paragraph_scraper.py" --url "$url"
  "$HOME/git/scripts/python/paragraphscraper/article_summarise_cosine.py" --file-name /tmp/para.txt --context > /tmp/summary.txt
}

floating_terminal() {
  bspc rule -a \* -o state=floating rectangle=1250x650+58+59
}

case "$url" in
  *"i.redd"*) open_images ;;
  *"imgur"*) open_images ;;
  *"jpg") open_images ;;
  *"png") open_images ;;
  *"v.red"*) mpv "$url" >/dev/null 2>&1 & ;;
  *"streama"*) mpv "$url" >/dev/null 2>&1 & ;;
  *)
    echo $visual
    link_handlers=$(printf "umpv\numpv_audio\nmpv\nbookmark\nfirefox\nfeh\nparagraph\nsummary\nytdl\nspeedread\nspeedread_summary" | rofi -matching fuzzy -dmenu -i -mesg "How should I open '$visual'?" -select)
    #echo "$link_handlers"
    case "$link_handlers" in
      umpv) "$HOME/git/scripts/python/umpv" "$url" >/dev/null 2>&1 & ;;
      umpv_audio) "$HOME/git/scripts/python/umpv_audio" "$url" >/dev/null 2>&1 & ;;
      mpv) mpv "$url" >/dev/null 2>&1 & ;;
      bookmark) buku --add "$url" toread,"$feed_title" --title "$title" >/dev/null 2>&1 & ;;
      firefox) firefox "$url" >/dev/null 2>&1 & ;;
      feh) open_images ;;
      paragraph) get_paragraph && floating_terminal && alacritty --hold -e /bin/zsh -c "sleep 1 && bat /tmp/para.txt && exit 0" ;;
      summary) get_paragraph && floating_terminal && alacritty --hold -e /bin/zsh -c "sleep 1 && bat /tmp/summary.txt && exit 0" ;;
      ytdl) youtube-dl "$url" >/dev/null 2>&1 & ;;
      speedread) get_paragraph && floating_terminal && alacritty --hold -e /bin/zsh -c "sleep 1 && /usr/bin/speedread -w 350 /tmp/para.txt && exit 0" ;;
      speedread_summary) get_paragraph && floating_terminal && alacritty --hold -e /bin/zsh -c "sleep 1 && /usr/bin/speedread -w 350 /tmp/summary.txt && exit 0" ;;
    esac
  ;;
esac
