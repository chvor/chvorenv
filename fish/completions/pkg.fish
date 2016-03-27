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
			if test -z "$argv[1]" -o "x$argv[1]" = "x$i"
				return 0
			end
			return 1
		end
	end
	return 1
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

complete -c pkg -n '__fish_pkg_has_subcommand info' -f -a "(__fish_print_packages)" -d 'Package name'
