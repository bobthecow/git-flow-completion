git-flow-completion
===================

Bash, Zsh and fish completion support for [git-flow](http://github.com/nvie/gitflow).

The contained completion routines provide support for completing:

 * git-flow init and version
 * feature, hotfix and release branches
 * remote feature, hotfix and release branch names


Installation for Bash
---------------------

To achieve git-flow completion nirvana:

 0. [Install git-completion](http://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion).

 1. Install `git-flow-completion.bash`. Either:

    1. Place it in your `bash_completion.d` folder, usually something like `/etc/bash_completion.d`,
       `/usr/local/etc/bash_completion.d` or `~/bash_completion.d`.

    2. Or, copy it somewhere (e.g. `~/git-flow-completion.bash`) and put the following line in the `.profile` or
       `.bashrc` file in your home directory:

            source ~/git-flow-completion.bash

 2. If you are using Git < 1.7.1, you will need to edit git completion (usually `/etc/bash_completion.d/git` or
    `git-completion.sh`) and add the following line to the `$command` case in `_git`:

        _git ()
        {
                [...]
                case "$command" in
                   [...]
                   flow)        _git_flow ;;		
                   *)           COMPREPLY=() ;;
                esac
        }


Installation for Zsh
--------------------

To achieve git-flow completion nirvana:

 0. Update your zsh's git-completion module to the newest version --
    [available here](http://sourceforge.net/p/zsh/code/ci/master/tree/Completion/Unix/Command/_git). Optional if you have an up-to-date version of zsh.

 1. Install `git-flow-completion.zsh`. Either:

    1. Place it in your `.zshrc`.

    2. Or, copy it somewhere (e.g. `~/.git-flow-completion.zsh`) and put the following line in
       your `.zshrc`:

            source ~/.git-flow-completion.zsh

    3. Or, use this file as an oh-my-zsh plugin.


Installation for fish
---------------------

To achieve git-flow completion nirvana:

 1. Install `git.fish` in your `~/.config/fish/completions` folder.


The Fine Print
--------------

Copyright (c) 2010-2014 [Justin Hileman](http://justinhileman.com)

Distributed under the [MIT License](http://creativecommons.org/licenses/MIT/)
