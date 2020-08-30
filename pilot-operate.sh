#!/bin/sh

LIST=/tmp/list
FILES=$(
   for file in "$@"; do
      readlink -f "$file"
   done
)

#===============================================================================
#                             Config
#===============================================================================

yank() { echo "$@" > $LIST; }
trash() { mv "$@" ~/.local/share/Trash; }

OPS="\
Trash:trash $FILES;
Delete:rm -fr $FILES;
Yank:yank $FILES;
Paste:rsync -a $(cat $LIST) $PWD;
Move:mv $(cat $LIST) $PWD;
Soft Link:cp -frus $(cat $LIST) $PWD;
Hard Link:cp -frul $(cat $LIST) $PWD;
"

#===============================================================================
#                             Script
#===============================================================================

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind=tab:down,btab:up"

get_config() {
   CURRENT_IFS=$IFS
   IFS=$(printf ';')
   for line in $OPS; do
      case $1 in
         -o) printf "%s" "${line%%:*}" ;;
         -c)
            case $line in
               *"$2"*) TEMP=${line%;*} && echo "${TEMP#*:}" && break ;;
            esac
            ;;
      esac
   done
   IFS=$CURRENT_IFS
}

CHOICE=$(get_config -o | fzf) && CMD=$(get_config -c "$CHOICE")
$CMD 2> /dev/null
