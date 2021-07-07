
fzf_tmux_installed() {
	if type fzf-tmux >/dev/null 2>&1; then
		return 0
	fi
	return 1
}

get_tmux_option() {
	local option=$1
	local default_value=$2
	local option_value=$(tmux show-option -gqv "$option")
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

get_projects() {
	tmuxinator list | tail -n +2 | tr -s ' '
}

command_prompt() {
	tmux command-prompt -p "($(get_projects)) $1 project:" "split-window tmuxinator $1 %1"
}

select_project_fzf() {
	projects=$(get_projects | tr ' ' '\n')
	echo "$projects" | fzf-tmux --layout=reverse --prompt "$1" --preview 'tmuxinator debug {}'
}
