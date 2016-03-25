function fish_title
	echo -sn "$USER@"(hostname -s)
	if test "$_" != "fish"
		echo -sn " $_"
	end
	echo -sn ' '
	set canonhome (readlink -f "$HOME")
	pwd | sed "s|$canonhome|~|g"
end
