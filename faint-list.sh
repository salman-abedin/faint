#!/bin/sh
#
# Helper script for faint; lists file and formats the view
# Dependencie: cat

# List of files & directories to ignore

#===============================================================================
#                             Config
#===============================================================================

DEPTH=1

# List of files & directories to ignore
FILTERS="\
node_modules;
package-lock.json;
yarn.lock;
.git;
"

#===============================================================================
#                             Script
#===============================================================================

DEPTH_PATH=/tmp/FAINT_DEPTH
FILTERS_PATH=/tmp/FAINT_FILTERS
LAST_PATH=/tmp/FAINT_LAST
LAST_DIR=

_get_filters() {
   CURRENT_IFS=$IFS
   IFS=$(printf ';')
   for line in $FILTERS; do
      printf "%s" "$line"
   done
   IFS=$CURRENT_IFS
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

list() {
   echo "$PWD" > $LAST_PATH
   find . -maxdepth "$(cat $DEPTH_PATH)" \
      ! -regex ".*\($(cat $FILTERS_PATH)\).*" \
      2> /dev/null

}

init() {
   read -r LAST_DIR < $LAST_PATH
   [ -s $DEPTH_PATH ] || echo "$DEPTH" > $DEPTH_PATH
   [ -s $FILTERS_PATH ] ||
      _get_filters |
      awk '{printf "%s\\|",$0;}' |
         sed -e 's/|\./|\\./g' -e 's/\\|$//g' \
            > $FILTERS_PATH
}

init
while :; do
   case $1 in
      -b) cd "${LAST_DIR%/*}" || exit ;;
      -d) shift && echo "$1" > $DEPTH_PATH ;;
      -e) shift && cd "$1" || exit ;;
      -l)
         shift
         NEW_DIR=$(echo "$1" | sed 's/\W //')
         DEST=$LAST_DIR/$NEW_DIR
         if ! cd "$DEST"; then
            mux "$DEST"
            cd "${DEST%/*}" || exit
         fi
         ;;
      *) break ;;
   esac
   shift
done
list | format
