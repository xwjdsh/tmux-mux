#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helper.sh"

main() {
  projects=$(get_projects | tr ' ' '\n')
  project=$(echo $projects | \
    fzf --layout=reverse \
        --prompt "project:" \
        --preview 'tmuxinator debug {}' \
    ) || return
  tmuxinator start "$project"
}

main
