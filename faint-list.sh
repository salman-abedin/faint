#!/bin/sh
#
# Helper script for faint; lists file and formats the view
# Dependencie: cat

# List of files & directories to ignore

#===============================================================================
#                             Config
#===============================================================================

MAX_DEPTH=1

# List of files & directories to ignore
FILTERS="\
node_modules;
package-lock.json;
.git;
"

#===============================================================================
#                             Script
#===============================================================================

MAX_DEPTH_PATH=/tmp/FAINT_MAX_DEPTH
FILTERS_PATH=/tmp/FAINT_FILTERS

_get_filters() {
   CURRENT_IFS=$IFS
   IFS=$(printf ';')
   for line in $FILTERS; do
      printf "%s" "$line"
   done
   IFS=$CURRENT_IFS
}

list() {
   find . -maxdepth "$(cat $MAX_DEPTH_PATH)" \
      ! -regex ".*\($(cat $FILTERS_PATH)\).*" \
      2> /dev/null
}

format() {
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
   done
}

[ -s $FILTERS_PATH ] ||
   _get_filters | awk '{printf "%s\\|",$0;}' | sed -e 's/|\./|\\./g' -e 's/\\|$//g' > $FILTERS_PATH

while :; do
   case $1 in
      -d) shift && echo "$1" > $MAX_DEPTH_PATH ;;
      -b | -l)
         shift
         # ns "$(dirname "$(readlink -f "${1#* }")")"
         DIR=$(echo "$1" | sed 's/\W //')
         [ "$1" = -b ] && DIR=${DIR%%/*}
         cd "$DIR" || {
            launch -f "$DIR"
            exit 0
         }
         ;;
      *) break ;;
   esac
   shift
done

[ -s $MAX_DEPTH_PATH ] || echo "$MAX_DEPTH" > $MAX_DEPTH_PATH

list | format
