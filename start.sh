#!/usr/bin/env bash

main() {
	str=$(tmuxinator list)
	str=$(echo "${str##*$'\n'}")
	projects=$(echo $str | tr -s ' ' '\n')
	tmux_session=$(echo $projects | \
		fzf --layout=reverse \
			--prompt "session:" \
			--preview 'tmuxinator debug {}' \
  ) || return
	tmuxinator start "$tmux_session"
}

main
