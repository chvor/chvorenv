if test "x$COLORTERM" = "xxfce4-terminal"
	set -gx TERM xterm-256color
end

if test -z "$DISPLAY"
	set BROWSER w3m
end

if test -n "$TMUX" -a "x$TERM" = "xscreen" -a "x$ORIGTERM" = "xxterm-256color"
	set -gx TERM screen-256color
end
