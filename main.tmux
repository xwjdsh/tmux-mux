#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helper.sh"

default_key_bindings_mux_start="'"
tmux_option_mux_start="@mux-start"

default_key_bindings_mux_delete="k"
tmux_option_mux_delete="@mux-delete"


set_mux_start_bindings() {
	local key_bindings=$(get_tmux_option "$tmux_option_mux_start" "$default_key_bindings_mux_start")
	local key
	for key in $key_bindings; do
		tmux bind-key $key run-shell -b "$CURRENT_DIR/start.sh"
	done
}

set_mux_delete_bindings() {
	local key_bindings=$(get_tmux_option "$tmux_option_mux_delete" "$default_key_bindings_mux_delete")
	local key
	for key in $key_bindings; do
		tmux bind-key $key run-shell -b "$CURRENT_DIR/delete.sh"
	done
}


main() {
	set_mux_start_bindings
	set_mux_delete_bindings
}

main
