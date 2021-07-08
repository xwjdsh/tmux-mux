#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helper.sh"

main() {
	if ! use_fzf_tmux; then
		command_prompt "stop" "$(get_space_split_running_projects)"
		return
	fi

	project=$(select_project_fzf "stop project: " "$(get_running_projects)")
	if [ -n "$project" ]; then
		tmuxinator stop $project 
	fi
}

main
