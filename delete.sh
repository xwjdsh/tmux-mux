#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helper.sh"

main() {
	if ! use_fzf_tmux; then
		command_prompt "delete"
		return
	fi

	project=$(select_project_fzf "delete project: ")
	if [ -n "$project" ]; then
		tmux split-window tmuxinator delete $project
	fi
}

main
