function tmux
	set -x ORIGTERM $TERM
	set -l addopt
	if test "x$TERM" = "xxterm-256color"
		if not contains -- -2 $argv
			set addopt "-2"
		end
	end
	command tmux $addopt $argv
end
