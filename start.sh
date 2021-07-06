#!/usr/bin/env bash

main() {
	str=$(tmuxinator list)
	str=$(echo "${str##*$'\n'}")
	projects=$(echo $str | tr -s ' ' '\n')
	project=$(echo $projects | \
		fzf --layout=reverse \
			--prompt "project:" \
			--preview 'tmuxinator debug {}' \
  ) || return
	tmuxinator start "$project"
}

main
