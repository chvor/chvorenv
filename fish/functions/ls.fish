function ls
	if not set -q LS_COLORS
		if type -q -f dircolors
			set -l colorfile
			for file in ~/.dir_colors ~/.dircolors /etc/DIR_COLORS
				if test -f $file
					set colorfile $file
					break
				end
			end
			eval (dircolors -c $colorfile | sed 's/>&\/dev\/null$//')
		end
	end
	if type -q -f gnuls
		command gnuls --color=auto -F $argv
	else
		command ls --color=auto -F $argv
	end
end
