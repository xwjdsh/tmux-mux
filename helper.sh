CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/options.sh"


use_fzf_tmux() {
	local disable_fzf=$(get_tmux_option "$tmux_option_mux_disable_fzf" "$default_mux_disable_fzf")
	if [ "$disable_fzf" == "on" ]; then
		return 1
	fi

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

get_line_split_projects() {
	get_projects | tr ' ' '\n'
}

get_running_projects() {
	local projects=$(get_line_split_projects)
	local sessions=$(tmux ls -F '#{session_name}')
	echo "$projects\n$sessions" | sort | uniq -d
}

command_prompt() {
	tmux command-prompt -p "($(get_projects)) $1 project:" "split-window tmuxinator $1 %1"
}

select_project_fzf() {
	projects=${2:-$(get_line_split_projects)}
	echo "$projects" | fzf-tmux --layout=reverse --prompt "$1" --preview 'tmuxinator debug {}'
}
