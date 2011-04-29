git-flow-completion
===================

Bash and Zsh completion support for [git-flow](http://github.com/nvie/gitflow)

The contained completion routines provide support for completing:

 * git-flow init and version
 * feature, hotfix and release branches
 * remote feature, hotfix and release branch names


Installation for Bash
---------------------

To achieve git-flow completion nirvana:

 0. [Install git-completion](http://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion).

 1. Install this file. Either:

    a. Place it in a `bash_completion.d` folder:

       * /etc/bash_completion.d
       * /usr/local/etc/bash_completion.d
       * ~/bash_completion.d

    b. Or, copy it somewhere (e.g. ~/.git-flow-completion.sh) and put the following line in
       your .bashrc:

           source ~/.git-flow-completion.sh

 2. If you are using Git < 1.7.1: Edit git-completion.sh and add the following line to the giant
    $command case in _git:

        flow)        _git_flow ;;


Installation for Zsh
--------------------

To achieve git-flow completion nirvana:

 0. Update your zsh's git-completion module to the newest verion --
    [available here](http://zsh.git.sourceforge.net/git/gitweb.cgi?p=zsh/zsh;a=blob_plain;f=Completion/Unix/Command/_git;hb=HEAD).

 1. Install this file. Either:

    a. Place it in your .zshrc:

    b. Or, copy it somewhere (e.g. ~/.git-flow-completion.zsh) and put the following line in
       your .zshrc:

           source ~/.git-flow-completion.zsh

    c. Or, use this file as an oh-my-zsh plugin.


The Fine Print
--------------

Copyright (c) 2011 [Justin Hileman](http://justinhileman.com)

Distributed under the [MIT License](http://creativecommons.org/licenses/MIT/)
