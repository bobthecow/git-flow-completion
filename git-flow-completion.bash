#!bash
#
# git-flow-completion
# ===================
# 
# Bash completion support for [git-flow](http://github.com/nvie/gitflow)
# 
# The contained completion routines provide support for completing:
# 
#  * git-flow init and version
#  * feature, hotfix and release branches
#  * remote feature, hotfix and release branch names
# 
# 
# Installation
# ------------
# 
# To achieve git-flow completion nirvana:
# 
#  0. Install git-completion.
# 
#  1. Install this file. Either:
# 
#     a. Place it in a `bash-completion.d` folder:
# 
#        * /etc/bash-completion.d
#        * /usr/local/etc/bash-completion.d
#        * ~/bash-completion.d
# 
#     b. Or, copy it somewhere (e.g. ~/.git-flow-completion.sh) and put the following line in
#        your .bashrc:
# 
#            source ~/.git-flow-completion.sh
# 
#  2. If you are using Git < 1.7.1: Edit git-completion.sh and add the following line to the giant
#     $command case in _git:
# 
#         flow)        _git_flow ;;
# 
# 
# The Fine Print
# --------------
# 
# Copyright (c) 2011 [Justin Hileman](http://justinhileman.com)
# 
# Distributed under the [MIT License](http://creativecommons.org/licenses/MIT/)

_git_flow ()
{
	local subcommands="init feature release hotfix help version"
	local subcommand="$(__git_find_on_cmdline "$subcommands")"
	if [ -z "$subcommand" ]; then
		__gitcomp "$subcommands"
		return
	fi

	case "$subcommand" in
	init)
		__git_flow_init
		return
		;;
	feature)
		__git_flow_feature
		return
		;;
	release)
		__git_flow_release
		return
		;;
	hotfix)
		__git_flow_hotfix
		return
		;;
	*)
		COMPREPLY=()
		;;
	esac
}

__git_flow_init ()
{
	local subcommands="help"
	local subcommand="$(__git_find_on_cmdline "$subcommands")"
	if [ -z "$subcommand" ]; then
		__gitcomp "$subcommands"
		return
	fi
}

__git_flow_feature ()
{
	local subcommands="list start finish publish track diff rebase checkout pull help"
	local subcommand="$(__git_find_on_cmdline "$subcommands")"
	if [ -z "$subcommand" ]; then
		__gitcomp "$subcommands"
		return
	fi

	case "$subcommand" in
	pull)
		__gitcomp "$(__git_remotes)"
		return
		;;
	checkout|finish|diff|rebase)
		__gitcomp "$(__git_flow_list_branches 'feature')"
		return
		;;
	publish)
		__gitcomp "$(comm -23 <(__git_flow_list_branches 'feature') <(__git_flow_list_remote_branches 'feature'))"
		return
		;;
	track)
		__gitcomp "$(comm -23 <(__git_flow_list_remote_branches 'feature') <(__git_flow_list_branches 'feature'))"
		return
		;;
	*)
		COMPREPLY=()
		;;
	esac
}

__git_flow_release ()
{
	local subcommands="list start finish track publish help"
	local subcommand="$(__git_find_on_cmdline "$subcommands")"
	if [ -z "$subcommand" ]; then
		__gitcomp "$subcommands"
		return
	fi
	
	case "$subcommand" in
	finish)
		__gitcomp "$(__git_flow_list_branches 'release')"
		return
		;;
	publish)
		__gitcomp "$(comm -23 <(__git_flow_list_branches 'release') <(__git_flow_list_remote_branches 'release'))"
		return
		;;
	track)
		__gitcomp "$(comm -23 <(__git_flow_list_remote_branches 'release') <(__git_flow_list_branches 'release'))"
		return
		;;
	*)
		COMPREPLY=()
		;;
	esac

}

__git_flow_hotfix ()
{
	local subcommands="list start finish help"
	local subcommand="$(__git_find_on_cmdline "$subcommands")"
	if [ -z "$subcommand" ]; then
		__gitcomp "$subcommands"
		return
	fi

	case "$subcommand" in
	finish)
		__gitcomp "$(__git_flow_list_branches 'hotfix')"
		return
		;;
	*)
		COMPREPLY=()
		;;
	esac
}

__git_flow_prefix ()
{
	case "$1" in
	feature|release|hotfix)
		git config "gitflow.prefix.$1" 2> /dev/null || echo "$1/"
		return
		;;
	esac
}

__git_flow_list_branches ()
{
	local prefix="$(__git_flow_prefix $1)"
	git branch 2> /dev/null | tr -d ' |*' | grep "^$prefix" | sed s,^$prefix,, | sort
}

__git_flow_list_remote_branches ()
{
	local prefix="$(__git_flow_prefix $1)"
	local origin="$(git config gitflow.origin 2> /dev/null || echo "origin")"
	git branch -r 2> /dev/null | sed "s/^ *//g" | grep "^$origin/$prefix" | sed s,^$origin/$prefix,, | sort
}

# alias __git_find_on_cmdline for backwards compatibility
if [ -z "`type -t __git_find_on_cmdline`" ]; then
	alias __git_find_on_cmdline=__git_find_subcommand
fi
