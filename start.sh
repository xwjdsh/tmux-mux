#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helper.sh"

main() {
	if ! fzf_installed; then
		command_prompt "start"
		return
	fi

	project=$(select_project_fzf)
	if [ -n "$project" ]; then
		tmuxinator start "$project"
	fi
}

main
