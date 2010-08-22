_git-flow ()
{
	local curcontext="$curcontext" state line
	typeset -A opt_args

	_arguments -C \
    	':command:->command' \
    	'*::options:->options'

	case $state in
		(command)
		
			local -a subcommands
			subcommands=(
				'init:Initialize a new git repo with support for the branching model.'
				'feature:Manage your feature branches.'
				'release:Manage your release branches.'
				'hotfix:Manage your hotfix branches.'
				'support:Manage your support branches.'
				'version:Shows version information.'
			)
			_describe -t commands 'git flow' subcommands
		;;
		
		(options)
			case $line[1] in
			
				(init)
					_arguments \
            			-f'[Force setting of gitflow branches, even if already configured]'
					;;
			
					(version)
					;;
			
					(hotfix)
						__git-flow-hotfix
					;;
			
					(release)
						__git-flow-release
					;;
			
					(feature)
						__git-flow-feature
					;;
      		esac
      	;;
  esac
}

__git-flow-release ()
{
	local curcontext="$curcontext" state line
	typeset -A opt_args

	_arguments -C \
    	':command:->command' \
    	'*::options:->options'

	case $state in
		(command)
		
			local -a subcommands
			subcommands=(
				'start:Start a new release branch'
				'finish:Finish a release branche.'
				'list:List all your release branches. (Alias to `git flow release`)'
			)
			_describe -t commands 'git flow release' subcommands
		;;
		
		(options)
			case $line[1] in
			
				(start)
					_arguments \
            			-F'[Fetch from origin before performing finish]'
					;;
			
				(version)
				;;
			
				(hotfix)
					__git-flow-hotfix
				;;
      		esac
      ;;
  esac
}

zstyle ':completion:*:*:git:*' user-commands flow:'description for foo'