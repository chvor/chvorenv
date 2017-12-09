if test "x$COLORTERM" = "xxfce4-terminal"
	set -gx TERM xterm-256color
end

if test -z "$DISPLAY"
	set BROWSER w3m
end

if test -n "$TMUX" -a "x$TERM" = "xscreen" -a "x$ORIGTERM" = "xxterm-256color"
	set -gx TERM screen-256color
end

if type -f -q fzf; and type -f -q ag
	set -x FZF_DEFAULT_COMMAND 'ag --hidden -g ""'
end

. ~/.config/fish/solarized.fish
