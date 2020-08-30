#!/bin/sh
#
# Explore using fzf

dir=${1:-$PWD}

FZF_DEFAULT_OPTS="\
   $FZF_DEFAULT_OPTS
   -m -e
   --prompt @${PWD##*/}\ 
   --bind 'space:abort+execute(pilot-operate {+})+execute(pilot-explore)'
   --bind \"\':execute(xdotool key period semicolon &)\"
   --bind ']:execute(lf $(readlink -f {}))'
   --bind 'enter:execute(tmux split-window -h \; last-pane \; kill-pane)'
   --bind '::accept+execute(tmux split-window -h -c $PWD \; send 'pilot-explore' Enter \; last-pane \; select-layout main-vertical )'
   "
export FZF_DEFAULT_OPT

while :; do
   cd "$dir" 2> /dev/null || launch -f "$(readlink -f "$dir")"
   dir=$(
      for file in * .*; do
         [ "$file" != . ] && echo "$file"
      done | fzf
   ) || break
done

# --bind "[:execute(lf $(realpath {})),enter:execute(tmux split-window -h \; select-pane -Z -t :.- \; kill-pane \; select-layout main-vertical),::execute(tmux split-window -h -c ' #{pane_current_path}' \; swap-pane -d -t :.1 \; select-layout main-vertical \; send \"launch -f $(realpath {})\" Enter)"

# _operate() {
#    printf "%s\n" "Delete\nYank\nMove\nPaste" |
#       fzf --prompt "Option: "
# }

# tmux split-window -h \; swap-pane -d -t :.1

# [ "$last_dir" != "$dir" ] && last_dir=$(readlink -f "$last_dir")

# tmux send "cd ${last_dir%/*}" "Enter"

# fzf --prompt "explore: " --bind "]:execute(lf $(realpath {})),[:execute(tmux split-window -h \; swap-pane -d -t :.1)"

#===============================================================================
#                             Exp
#===============================================================================

# Explore files on lf using the last visited path
# LAST_PATH=~/.local/share/LF_LAST_PATH
# if [ "$*" ]; then
#    lf -last-dir-path $LAST_PATH "$*"
# else
#    lf -last-dir-path $LAST_PATH "$(cat $LAST_PATH)"
# fi
