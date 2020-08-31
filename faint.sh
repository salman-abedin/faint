#!/bin/sh
#
# A fuzzy file explorer
# Dpendencies: fzf, tmux, launch & faint-operate
# Usage: faint (launch on the current directory)
#        faint -l (launch on the last visited directory)

#===============================================================================
#                             Config
#===============================================================================

MAX_DEPTH=3

# List of files & directories to ignore
FILTERS="\
node_modules;
package-lock.json;
.git;
colors/;
"

#===============================================================================
#                             Script
#===============================================================================

FILTERS_PATH=/tmp/FAINT_FILTERS
LAST_PATH=~/.local/share/FAINT_LAST_PATH

FZF_DEFAULT_OPTS="\
   $FZF_DEFAULT_OPTS
   -m
   --bind 'space:abort+execute(faint-operate {+})+execute(faint)'
   --bind \"\':abort+execute(tmux send Enter .. Enter f Enter Enter)\"
   --bind '\\:execute(lf $(readlink -f {}))'
   --bind \"[:execute(kill -35 $$)+accept\"
   --bind 'enter:execute(tmux split-window -h \; last-pane \; kill-pane)'
   --bind '::accept+execute(tmux split-window -h \; send faint Enter \; last-pane \; select-layout main-vertical )'
   "

mode=

_get_filters() {
   CURRENT_IFS=$IFS
   IFS=$(printf ';')
   for line in $FILTERS; do
      printf "%s" "$line"
   done
   IFS=$CURRENT_IFS
}

_launch() {
   cd "$1" 2> /dev/null || {
      case $mode in
         choose) launch -c "$1" ;;
         *) launch -f "$1" ;;
      esac
   }
}

_list() {
   find . -maxdepth "$MAX_DEPTH" \
      ! -regex ".*\($(cat $FILTERS_PATH)\).*" \
      2> /dev/null
}

_format() {
   while read -r file; do
      [ "$file" = . ] && continue

      if [ -d "$file" ]; then
         PREFIX="📁"
      else
         EXT=${file##*.}
         case $EXT in
            iso | img) PREFIX="📀" ;;
            png | ico) PREFIX="🖼" ;;
            jpg | jpeg) PREFIX="📸" ;;
            part) PREFIX="💔" ;;
            json) PREFIX="📒" ;;
            md) PREFIX="📘" ;;
            tex) PREFIX="📜" ;;
            css) PREFIX="🎨" ;;
            html) PREFIX="🌎" ;;
            pdf | epub) PREFIX="📚" ;;
            mp4 | mkv) PREFIX="🎥" ;;
            *) PREFIX="📃" ;;
         esac
      fi
      echo "$PREFIX ${file#./}"
      # echo "$PREFIX $file"
   done
}

export FZF_DEFAULT_OPT

[ -s $FILTERS_PATH ] ||
   _get_filters | awk '{printf "%s\\|",$0;}' | sed -e 's/|\./|\\./g' -e 's/\\|$//g' > $FILTERS_PATH

case $1 in
   # -l) read -r dir < $LAST_PATH && dir=${dir%/*} ;;
   -d) MAX_DEPTH=$2 ;;
   *) dir=${1:-$PWD} ;;
esac

trap 'mode=choose' RTMIN+1

while :; do
   dir=$(_list | _format | fzf) || break
   _launch "${dir#* }"
   # last_dir=${dir#* }
done

# [ -n "$last_dir" ] && readlink -f "$last_dir" > $LAST_PATH

#===============================================================================
#                             Exp
#===============================================================================

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
