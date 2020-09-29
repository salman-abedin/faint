#!/bin/sh
#
# General purpose launching script

silence() { setsid -f "$@" > /dev/null 2>&1 & }

launch_dwm() {
   while :; do
      dwm 2> ~/.local/share/dwm.log
   done
}

choose() {
   choice=$(printf "📕 Zathura\n📘 Evince\n📖 Foxit Reader\n📙 Master PDF Editor\n💻 Code\n🎥 MPV\n🌏 Browser" |
      $DMENU -p "Open with" | sed "s/\W//g") &&
      case "$choice" in
         Zathura) silence zathura "$1" ;;
         Evince) silence evince "$1" ;;
         Browser) silence $BROWSER --new-window "$1" ;;
         FoxitReader) silence foxitreader "$1" ;;
         MasterPDFEditor) silence masterpdfeditor4 "$1" ;;
         Code) silence code "$1" ;;
         MPV) silence mpv "$1" ;;
            # MPV) silence mpv --shuffle "$1" ;;
      esac
}

link() {
   case "$1" in
      *mkv | *webm | *mp4 | *mp3 | *youtube.com/watch* | *youtube.com/playlist* | *youtu.be*)
         qmedia "$1"
         ;;
      *)
         silence "$BROWSER" "$1"
         # silence firefox "$1"
         ;;
   esac
}

dir() {
   launch --tmux 2> /dev/null # Personal Script
   if pidof tmux; then
      tmux new-window
   else
      tmux new-session -d \; switch-client
   fi
   if pidof "$TERMINAL"; then
      [ "$(pidof "$TERMINAL")" != "$(xdo pid)" ] &&
         xdo activate -N Alacritty
   else
      "$TERMINAL" -e tmux attach &
   fi
   tmux send "$FILE ${1:-~}" "Enter"
}

launch_file() {
   case $1 in
      *.ar.*)
         alacritty \
            --config-file ~/.config/alacritty/alacritty_ar.yml \
            -e "$EDITOR" "$@" &
         exit
         ;;
      *.url)
         $BROWSER "$(cat "$@")"
         exit
         ;;
      *.sent)
         devour sent "$@" &
         sleep 1
         # bspc node -t fullscreen
         xdotool key Super+f
         exit
         ;;
      *.dev)
         devour "$TERMINAL" nvim "$1"
         exit
         ;;
      *.gpg)
         gpg -d "$1" > "${1%.gpg}"
         exit
         ;;
      *toy.*)
         # tmux split-window -h -l 30 "$EDITOR ${1%/*}/output" \; last-pane
         tmux split-window -h -l 50 \; last-pane
         ;;
   esac

   case $(file --mime-type "$1" -bL) in
      text* | *x-empty | *json | *octet-stream)
         $EDITOR "$1"
         # exit
         ;;
      *directory)
         $FILE "$1"
         ;;
      *html)
         $BROWSER "$1"
         ;;
      video* | audio* | *gif)
         qmedia "$1"
         ;;
      *pdf | *postscript | *epub+zip | *vnd.djvu)
         silence "$READER" "$1"
         sleep 2 && transset-df -a 0.90
         ;;
      *svg+xml)
         silence magick display "$1"
         ;;
      image*)
         silence feh --keep-zoom-vp -A "setdisplay --bg %F" -B 'black' -d --edit --start-at \
            "$1"
         ;;
      *x-bittorrent)
         transmission-remote -a "$1"
         ;;
      *.document)
         pandoc "$1" -o "${1%.*}.pdf"
         $0 -f "${1%.*}.pdf"
         ;;
      application*)
         extract --clean "$1"
         ;;
      *)
         return
         ;;
   esac

}

terminal() {
   if pidof tmux > /dev/null 2>&1; then
      tmux new-window
   else
      tmux new-session -d \; switch-client
   fi
   pidof "$TERMINAL" || "$TERMINAL" -e tmux attach &
   # if pidof "$TERMINAL"; then
   # [ "$(pidof "$TERMINAL")" != "$(xdo pid)" ] &&
   # xdo activate -N st-256color
   # xdo activate -N Alacritty
   # else
   # "$TERMINAL" -e tmux attach &
   # "$TERMINAL"
   # sleep 0.5
   # xdo key_press -k 28
   # xdo key_release -k 28
   # xdo key_press -k 38
   # sleep 0.2
   # xdo key_release -k 38
   # xdo key_press -k 36
   # sleep 0.2
   # xdo key_release -k 36
   # fi
}

launch_tmux() {
   pidof tmux > /dev/null 2>&1 || {
      tmux new-session -d \
         -n 'chat' 'weechat' \; \
         new-window -n 'schedule' 'calcurse' \; \
         split-window -h 'neomutt' \; last-pane
   }
   # -n 'news' 'newsboat' \; \
   # new-window -n 'chat' 'weechat' \; \
}

launch_api() {
   SERVER=/mnt/horcrux/innovations/quick_assist/server
   tmux \
      new-window -n 'server' \; \
      send "cd $SERVER" 'Enter' \; \
      send "yrd" 'Enter' \; \
      split-window -h \; \
      send 'da mongod' 'Enter' \; last-pane
}

while :; do
   case $1 in
      --tmux | -t) launch_tmux ;;
      --terminal | -T) terminal ;;
      --file | -f) shift && launch_file "$1" ;;
      --choose | -c) shift && choose "$1" ;;
      --link | -l) shift && link "$1" ;;
      --dir | -d) shift && $FILE "$1" ;;
      --dwm | -D) launch_dwm ;;
      --api | -a) launch_api ;;
      *) break ;;
   esac
   shift
done
