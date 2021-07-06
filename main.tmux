#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helper.sh"

default_key_bindings_mux_start="'"
tmux_option_mux_start="@mux-start"


set_mux_start_bindings() {
	local key_bindings=$(get_tmux_option "$tmux_option_mux_start" "$default_key_bindings_mux_start")
	local key
	for key in $key_bindings; do
		if fzf_installed; then
			tmux bind-key $key run "tmux split-window 'source $CURRENT_DIR/start.sh'"
		else
			tmux bind-key $key run "tmux command-prompt -p '($(get_projects)) project:' 'split-window tmuxinator start %1'"
		fi
	done
}

main() {
	set_mux_start_bindings
}

main
