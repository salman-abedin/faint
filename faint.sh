#!/bin/sh
#
# A fuzzy file explorer
# Dpendencies: fzf, tmux, launch & faint-operate
# Usage: faint (launch on the current directory)
#        faint -l (launch on the last visited directory)

FZF_DEFAULT_OPTS="\
   $FZF_DEFAULT_OPTS
   -m
   --bind 'space:abort+execute(faint-operate {+})+execute(faint)'
   --bind ';:reload(faint-list -l {})+clear-query'
   --bind ';:reload(faint-list -l {})+clear-query'
   --bind \"':reload(faint-list -b)+clear-query\"
   "

export FZF_DEFAULT_OPT
faint-list -e "${1:-$PWD}" | fzf

#===============================================================================
#                             Exp
#===============================================================================

# --bind '::accept+execute(tmux split-window -h \; send faint Enter \; last-pane \; select-layout main-vertical )'
# --bind \"':reload(faint-list -b {}))+clear-query\"
# --bind 'enter:execute(tmux split-window -h \; last-pane \; kill-pane)'
# --bind ';:reload(faint-list -l $(readlink -f {}))+clear-query'

# mode=

# case $1 in
#    # -l) read -r dir < $LAST_PATH && dir=${dir%/*} ;;
#    -l) read -r dir < $LAST_PATH ;;
#    -d) echo "$2" > $DEPTH_PATH_PATH ;;
#    *) dir=${1:-$PWD} && echo 3 > $DEPTH_PATH_PATH ;;
# esac

# trap 'mode=choose' RTMIN+1
# trap '$0 ${last_dir%/*}' RTMIN+2

# while :; do
#    last_dir=${dir#* }
#    _launch "${dir#* }"
#    dir=$(faint-list | fzf) || break
#    # dir=$(_list | _format | fzf) || break
# done
# echo "$last_dir" > $LAST_PATH 2> /dev/null

# --bind '\':reload(faint-list -b $(readlink -f {}))'
# --bind \"]:execute(kill -35 $$)+accept\"
# --bind '\\:execute(lf $(readlink -f {}))'
# --bind \"\':abort+execute(kill -36 $$)\"

# LAST_PATH=~/.local/share/FAINT_LAST_PATH

# [ -n "$last_dir" ] && readlink -f "$last_dir" > $LAST_PATH

# --bind \"\':execute(xdotool key period semicolon &)\"

# for file in * .*; do

#    [ "$file" = . ] || [ "$file" = "*" ] && continue

#    FILE=$(readlink -f "$file")

#    if [ -d "$FILE" ]; then
#       echo "📁 $file"
#    else
#       EXT=${file##*.}
#       case $EXT in
#          iso | img) echo "📀 $file" ;;
#          png | ico) echo "🖼 $file" ;;
#          jpg | jpeg) echo "📸 $file" ;;
#          part) echo "💔 $file" ;;
#          json) echo "📒 $file" ;;
#          md) echo "📘 $file" ;;
#          tex) echo "📜 $file" ;;
#          css) echo "🎨 $file" ;;
#          html) echo "🌎 $file" ;;
#          pdf | epub) echo "📚 $file" ;;
#          mp4 | mkv) echo "🎥 $file" ;;
#          *) echo "📃 $file" ;;
#       esac
#    fi
# done | fzf

# --bind '::accept+execute(tmux split-window -h -c \"$dir\" \; send faint Enter \; last-pane \; select-layout main-vertical )'

# --bind '::accept+execute(tmux split-window -h -c $dir \; send 'faint' Enter \; last-pane \; select-layout main-vertical )'

# elif [ -x "$FILE" ]; then
#    echo "🎯 $file"

# --bind '::accept+execute(tmux split-window -h -c $PWD \; send 'faint' Enter \; last-pane \; select-layout main-vertical )'

# --bind \"[:execute(launch -c $(readlink -f {} | sed 's/[^[:alnum:]] //'))\"

# FORWARD=\;
# OPEN_NEW=:
# BACKWARD=\'
# OPERATE=space
# EXPLORE=[
# SPAWN=enter
