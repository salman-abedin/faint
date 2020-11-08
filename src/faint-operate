#!/bin/sh
#
# Helper script for faint. Allows misc operations on files
# Dependencie: cat

LIST=/tmp/list
FILES=$(
   for file in "$@"; do
      readlink -f "${file#* }"
   done
)

#===============================================================================
#                             Config
#===============================================================================

yank() {
   echo "$*" | xsel -b
   echo "$*" > $LIST
}

OPS="\
Trash:mv $FILES $HOME/.local/share/Trash;
Delete:rm -fr $FILES;
Yank:yank $FILES;
Paste:rsync -a $(cat $LIST) .;
Duplicate:rsync -a $FILES $FILES~;
Move:mv $(cat $LIST) .;
Soft Link:cp -frus $(cat $LIST) .;
Hard Link:cp -frul $(cat $LIST) .;
"

# Paste:rsync -a $(cat $LIST) $PWD;

#===============================================================================
#                             Script
#===============================================================================

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

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind=tab:down,btab:up"

CHOICE=$(get_config -o | fzf) &&
   CMD=$(get_config -c "${CHOICE#* }") &&
   $CMD 2> /dev/null

#===============================================================================
#                             Exp
#===============================================================================

# readlink -f "${file#* }"
