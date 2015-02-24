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
 
         1. Install the plugin by cloning this repository to your directory for [custom oh-my-zsh plugins](https://github.com/robbyrussell/oh-my-zsh#customization):
         
         `git clone https://github.com/bobthecow/git-flow-completion ~/.oh-my-zsh/custom/plugins/git-flow-completion`
         
         After doing that, your file tree ought to look like this:
         
         ![](https://cloud.githubusercontent.com/assets/2547625/3866984/2f28fc4c-1feb-11e4-8c37-79627d655000.png)
         
         2. Turn the plugin on by updating your zsh configuration file, `~/.zshrc`
         
             1. `open ~/.zshrc`
             2. Find the plugins section. It'll look like this:
             
                     # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
                     # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
                     # Example format: plugins=(rails git textmate ruby lighthouse)
                     plugins=(<some-plugin> <another-plugin> <third-plugin>)
             
             3. Add `git-flow-completion` to the list of plugins within the parentheses.
             4. Save
         
         3. Reload Terminal

Installation for fish
---------------------

To achieve git-flow completion nirvana:

 1. Install `git.fish` in your `~/.config/fish/completions` folder.


The Fine Print
--------------

Copyright (c) 2010-2015 [Justin Hileman](http://justinhileman.com)

Distributed under the [MIT License](http://creativecommons.org/licenses/MIT/)
