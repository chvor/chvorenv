function __prompt_git_branch
	set -l branch_symbol " "
	set -l branch (git symbolic-ref --quiet HEAD ^/dev/null)
	or set -l branch (git rev-parse --short HEAD ^/dev/null)
	and echo -n "$branch_symbol"(basename $branch)
end

function __prompt_git_status
	git rev-parse --is-inside-work-tree >/dev/null ^/dev/null; or return 1
	set -l added_symbol "●"
	set -l unmerged_symbol "✗"
	set -l modified_symbol "+"
	set -l clean_symbol "✔"
	set -l untracked_symbol "…"
	set -l ahead_symbol "↑"
	set -l behind_symbol "↓"
	set -l unmerged_count 0
	set -l modified_count 0
	set -l added_count 0
	set -l untracked_count 0
	git status --porcelain -unormal ^/dev/null | cut -c 1-2 | tr ' ?!' '_TI' | while read mode name
		switch "$mode"
			case 'A_'
				set added_count (math "$added_count + 1")
			case 'AM'
				set added_count (math "$added_count + 1")
				set modified_count (math "$modified_count + 1")
			case '_M' 'M_'
				set modified_count (math "$modified_count + 1")
			case 'TT'
				set untracked_count (math "$untracked_count + 1")
			case 'U?' '?U' 'AA' 'DD'
				set unmerged_count (math "$unmerged_count + 1")
		end
	end

	set -l behind_count 0
	set -l ahead_count 0
	git rev-list --left-right --count '@{upstream}...HEAD' ^/dev/null | read behind_count ahead_count

	if test (math "$behind_count + $ahead_count + $unmerged_count + $modified_count + $added_count + $untracked_count") -eq 0
		echo -n $clean_symbol
		return 0
	end

	set -l l ""
	if test $ahead_count -gt 0
		echo -n $l$ahead_symbol$ahead_count
		set l ' '
	end
	if test $behind_count -gt 0
		echo -n $l$behind_symbol$behind_count
		set l ' '
	end
	if test $unmerged_count -gt 0
		echo -n $l$unmerged_symbol$unmerged_count
		set l ' '
	end
	if test $modified_count -gt 0
		echo -n $l$modified_symbol$modified_count
		set l ' '
	end

	if test $added_count -gt 0
		echo -n $l$added_symbol$added_count
		set l ' '
	end

	if test $untracked_count -gt 0
		echo -n $l$untracked_symbol
		set l ' '
	end
end

function fish_right_prompt
	set -l last_status $status
	set -l wrap '\e['
	set -l end_wrap m
	set -l s " "
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
	set -l c_fg $wrap'38;5;10'$end_wrap
	set -l c_bg $wrap'48;5;0'$end_wrap
	set -l c_sep_fg $wrap'38;5;0'$end_wrap
	set -l warn_fg $wrap'38;5;15'$end_wrap
	set -l warn_bg $wrap'48;5;9'$end_wrap
	set -l warn_sep_fg $wrap'38;5;9'$end_wrap

	set -l t (__prompt_git_status)
		and printf $c_sep_fg$rsep$c_fg$c_bg$s'%s'$s "$t"

	set -l t (__prompt_git_branch)
		and printf $b_sep_fg$rsep$b_fg$b_bg$s'%s'$s "$t"

	# Always print the warn sep, but don't always print the
	# last status.
	printf $warn_sep_fg$rsep
	test $last_status -ne 0
		and printf $warn_fg$warn_bg$s$last_status$s
	printf $reset
end
