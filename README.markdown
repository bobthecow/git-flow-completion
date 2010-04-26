git-flow-completion
===================

Bash completion support for [Git Flow](http://github.com/nvie/gitflow)

The contained completion routines provide support for completing:

 * git-flow init and version
 * feature, hotfix and release branches
 * remote feature branch names (for `git-flow feature track`)


Installation
------------

To achieve git-flow completion nirvana:

 0. Install git-completion.

 1. Install this file. Either:

    a. Place it in a `bash-completion.d` folder:

       * /etc/bash-completion.d
       * /usr/local/etc/bash-completion.d
       * ~/bash-completion.d

    b. Or, copy it somewhere (e.g. ~/.git-flow-completion.sh) and put the following line in
       your .bashrc:

           source ~/.git-flow-completion.sh

 3. Edit git-completion.sh and add the following line to the giant $command case in _git:

        flow)        _git_flow ;;


Requirement 3 will go away as soon as I figure out how to properly (and predictably) hijack
the `complete -F` ownership for `git` without breaking regular `git-completion`...



The Fine Print
--------------

Copyright (c) 2010 [Justin Hileman](http://justinhileman.com)

Distributed under the [MIT License](http://creativecommons.org/licenses/MIT/)
