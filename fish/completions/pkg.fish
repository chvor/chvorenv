complete -e -c pkg
set -g __fish_pkg_subcommands (pkg -l)

function __fish_pkg_has_subcommand
	set -l skip_next 0
	set -l first 1
	for i in (commandline -opc)
		if test $first -eq 1
			set first 0
			continue
		end
		if test $skip_next -eq 1
			set skip_next 0
		else if contains -- $i -o --option -j --jail -c --chroot -r --rootdir -C --config -R --repo-conf-dir
			set skip_next 1
		else if not printf "%s" $i | grep -q '^-'
			if test -z "$argv[1]"
				return 0
			else if test $argv[1] = "-p"
				printf "%s" $i
				return 0
			else if contains -- $i $argv
				return 0
			end
			return 1
		end
	end
	return 1
end

function __fish_pkg_can_show_packages
	if not __fish_pkg_has_subcommand info
		return 1
	end
	if contains -- (commandline -tc) -F --file
		return 1
	end
	return 0
end

function __fish_pkg_has_file_option
	__fish_pkg_has_subcommand info
end

function __fish_pkg_has_glob_option
	__fish_pkg_has_subcommand info which
end

function __fish_pkg_has_origin_option
	__fish_pkg_has_subcommand info which
end

function __fish_pkg_has_quiet_option
	__fish_pkg_has_subcommand info which
end

complete -c pkg -n 'not __fish_pkg_has_subcommand' -s v -l version -d 'Display the current version of pkg.'
complete -c pkg -n 'not __fish_pkg_has_subcommand' -s d -l debug -d 'Show debug information.'
complete -c pkg -n 'not __fish_pkg_has_subcommand' -s l -l list -d 'List all the available command names'
complete -c pkg -n 'not __fish_pkg_has_subcommand' -s o -l option -d '(option=value)'
complete -c pkg -n 'not __fish_pkg_has_subcommand' -s N -d 'Activation status check mode.'
complete -c pkg -n 'not __fish_pkg_has_subcommand' -s j -l jail -d '(jail name or id)'
complete -c pkg -n 'not __fish_pkg_has_subcommand' -s c -l chroot -d '(chroot path)'
complete -c pkg -n 'not __fish_pkg_has_subcommand' -s r -l rootdir -d '(root directory)'
complete -c pkg -n 'not __fish_pkg_has_subcommand' -s C -l config -d '(configuraiton file)'
complete -c pkg -n 'not __fish_pkg_has_subcommand' -s R -l repo-conf-dir -d '(repo conf dir)'
complete -c pkg -n 'not __fish_pkg_has_subcommand' -s 4 -d 'use IPv4'
complete -c pkg -n 'not __fish_pkg_has_subcommand' -s 6 -d 'use IPv6'

set -l IFS '|'
pkg help | grep '^[^A-Z] *[a-z][a-z]*' | sed -E 's/^. *([^ ]*)  *(.*)$/\1|\2/' | while read -l cmd desc
	complete -c pkg -n 'not __fish_pkg_has_subcommand' -f -a $cmd -d "$desc"
end

complete -c pkg -n '__fish_pkg_can_show_packages' -f -a "(__fish_print_packages)" -d 'Package name'
complete -c pkg -n '__fish_pkg_has_file_option' -r -s F -l file -d 'Package file name'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s a -l all -d 'Display all installed packages.'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s A -l annotations -d 'Display any annotations added to the package.'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s C -l case-sensitive -d 'Make matching case sensitive'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s f -l full -d 'Display full information'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s R -l raw -d 'Display the raw manifest'
complete -c pkg -n '__fish_pkg_has_subcommand info' -x -l raw-format -d 'Raw output format' -a "json json-compact yaml"
complete -c pkg -n '__fish_pkg_has_subcommand info' -s e -l exists -d 'Check if package exists'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s D -l pkg-message -d 'Show the pkg-message for matching packages.'
complete -c pkg -n '__fish_pkg_has_glob_option' -s g -l glob -d 'Treat pkg-name as a shell glob pattern.'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s i -l case-insensitive -d 'Make matching case insensitive'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s I -l comment -d 'Display the specified packages and their comments.'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s x -l regex -d 'Treat pkg-name as a regular expression'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s d -l dependencies -d 'Display dependencies for pkg-name'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s r -l required-by -d 'Display packages required by pkg-name'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s k -l locked -d 'Show the locking status for pkg-name.'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s l -l list-files -d 'Display all files installed by pkg-name.'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s b -l provided-shlibs -d 'Display all shared libraries provided by pkg-name.'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s B -l required-shlibs -d 'Display all shared libraries used by pkg-name.'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s s -l size -d 'Display the total size of files installed by pkg-name.'
complete -c pkg -n '__fish_pkg_has_quiet_option' -s q -l quiet -d 'Prints only the requested information.'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s O -l by-origin -d 'Search is done by the pkg-name origin.'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s E -l show-name-only -d 'Only shows the package name.'
complete -c pkg -n '__fish_pkg_has_origin_option' -s o -l origin -d 'Display pkg-name origin.'
complete -c pkg -n '__fish_pkg_has_subcommand info' -s p -l prefix -d 'Display the installation prefix'

complete -c pkg -n '__fish_pkg_has_subcommand which' -s p -l path-search -d 'Search for the filename in PATH.'
