#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

default_key_bindings_mux_start="'"
tmux_option_mux_start="@mux-start"

get_tmux_option() {
	local option=$1
	local default_value=$2
	local option_value=$(tmux show-option -gqv "$option")
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

set_mux_start_bindings() {
	local key_bindings=$(get_tmux_option "$tmux_option_mux_start" "$default_key_bindings_mux_start")
	local key
	for key in $key_bindings; do
		# tmux bind $key run "tmux split-window 'source $CURRENT_DIR/fts.sh'; tmux send-keys 'fts; exit' Enter"
		tmux bind $key run "tmux split-window 'source $CURRENT_DIR/start.sh'"
	done
}

main() {
	set_mux_start_bindings
}

main
