#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helper.sh"

main() {
	if ! fzf_installed; then
		command_prompt "delete"
		return
	fi

	project=$(select_project_fzf)
	if [ -n "$project" ]; then
		tmux split-window tmuxinator delete "$project"
	fi
}

main
