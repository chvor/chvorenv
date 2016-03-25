function __prompt_cwd
	set -l dir_limit 3
	set -l truncation "⋯"
	set -l part_count 0
	set -l formatted_cwd
	set -l dir_sep "  "
	set -l tilde "~"

	set -l home ~
	set -l cwd (pwd | sed "s|^$home|$tilde|")
	set -l first_char (echo $cwd | cut -c 1)

	if test $first_char = '~';
		set cwd (echo $cwd | cut -c 2-)
	end

	set -l IFS '/'
	echo $cwd | read -l -a cwd_split
	for part in $cwd_split[-1..1]
		set formatted_cwd "$dir_sep$part$formatted_cwd"
		set part_count (math "$part_count + 1")
		if test $part_count -ge $dir_limit
			set first_char $truncation
			break
		end
	end

	echo -n "$first_char$formatted_cwd"
end

function fish_prompt --description 'Write out the prompt'
	if not set -q __prompt_hostname
		set -g __prompt_hostname (hostname -s)
	end

	set -l wrap '\e['
	set -l end_wrap m
	set -l space " "
	set -l sep ""
	set -l rsep ""
	set -l alt_sep ""
	set -l alt_rsep ""
	set -l reset $wrap'0'$end_wrap
	set -l reset_bg $wrap'49'$end_wrap
	set -l a_fg $wrap'38;5;15'$end_wrap
	set -l a_bg $wrap'48;5;3'$end_wrap
	set -l a_sep_fg $wrap'38;5;3'$end_wrap
	set -l b_fg $wrap'38;5;7'$end_wrap
	set -l b_bg $wrap'48;5;11'$end_wrap
	set -l b_sep_fg $wrap'38;5;11'$end_wrap

	echo -en $a_fg$a_bg$space$__prompt_hostname$space$a_sep_fg
	echo -en $b_bg$sep$b_fg$b_bg$space(__prompt_cwd)$space$b_sep_fg
	echo -en $reset_bg$sep$reset$space
end
