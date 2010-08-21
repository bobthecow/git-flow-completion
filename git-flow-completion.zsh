_git_flow ()
{
	local -a subcommands
	subcommands=(
	  'init:Initialize a new git repo with support for the branching model.'
	  'feature:Manage your feature branches.'
	  'release:Manage your release branches.'
	  'hotfix:Manage your hotfix branches.'
	  'support:Manage your support branches.'
	  'version:Shows version information.'
	)
	return '42'
}

compdef _git_flow git-flow