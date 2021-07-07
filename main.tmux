#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helper.sh"
source "$CURRENT_DIR/options.sh"

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

set_mux_stop_bindings() {
	local key_bindings=$(get_tmux_option "$tmux_option_mux_stop" "$default_key_bindings_mux_stop")
	local key
	for key in $key_bindings; do
		tmux bind-key $key run-shell -b "$CURRENT_DIR/stop.sh"
	done
}

main() {
	set_mux_start_bindings
	set_mux_stop_bindings
	set_mux_delete_bindings
}

main
