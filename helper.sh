
fzf_installed() {
	if type fzf >/dev/null 2>&1; then
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
	str=$(tmuxinator list)
	echo "${str##*$'\n'}" | tr -s ' '
}
