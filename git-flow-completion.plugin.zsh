# zsh completion module for git flow
#  • use an up-to-date git-completion module, f.ex. from here:
#    http://zsh.git.sourceforge.net/git/gitweb.cgi?p=zsh/zsh;a=blob_plain;f=Completion/Unix/Command/_git;hb=HEAD
#  • source this file somewhere in your .zshrc (eg. source ~/git-flow-completion.plugin.zsh)
#  • or use this file as a oh-my-zsh plugin

# ------------------------------------------------------------------------------

# Tip: Use indentation based folding when browsing this file.

# Note: I will not include the 'help' subcommands because all information is
# already provided by the completion. Nevertheless this would be as simple as
# adding '(-):::(help)' to _arguments.

# ------------------------------------------------------------------------------

# make sub-command known to zsh's builtin git completion
zstyle ':completion:*:*:git:*' user-commands flow:'git-flow branching model'

_git-flow ()
{
  local context state line
  typeset -A opt_args

  _arguments \
    ':command:->command' \
    '*::options:->options'
  case $state in
    (command)
      local -a commands

      commands=(
        'init:initialize repository for use with git-flow'
        'feature:develop new features for the upcoming or a distant future release'
        'release:prepare a new production release'
        'hotfix:act immediately upon an undesired state of a live production version'
        'support:long-term support branches of historic versions'
        'help'
        'version'
      )
      _describe -t commands 'git flow command' commands
      ;;
    (options)
      case $line[1] in
        (help) ;&
        (version)
          ;;
        (init)
          _arguments \
            {-f,--force}'[force setting of gitflow branches, even if already configured]' \
            {-d,--default}'[use default branch naming conventions]'
          ;;
        *) # subcommand-specific completion
          if (( $+functions[__git-flow-$words[1]] )); then
            _call_function ret __git-flow-$words[1]
            return ret
          fi
          ;;
      esac
      ;;
  esac

  # ----------------------------------------------------------------------------

  __git-flow-feature () {
    local prefix=$(__git_flow_prefix "feature")
    local origin="$(git config gitflow.origin 2> /dev/null || echo "origin")"

    local context state line
    typeset -A opt_args

    _arguments \
      ':command:->command' \
      '*::options:->options'
    case $state in
      (command)
        local -a commands

        commands=('list' 'start' 'finish' 'publish' 'track' 'diff' 'rebase' 'checkout' 'pull')
        _describe -t commands 'git flow feature command' commands
        ;;
      (options)
        case $line[1] in
          (list)
            _arguments {-v,--verbose}'[verbose (more) output]'
            ;;
          (start)
            _arguments \
              {-F,--fetch}'[fetch from origin before performing local operation]' \
              ':name:__git_guard_branch-name' \
              '::base:__git_revisions'
            ;;
          (finish)
            _arguments \
              {-F,--fetch}'[fetch from origin before performing finish]' \
              {-r,--rebase}'[rebase instead of merge]' \
              {-k,--keep}'[keep branch after performing finish]' \
                ":name:__git_flow_branch_names --prefix $prefix"
            ;;
          (publish)
            _arguments \
              ":name:__git_flow_branch_names --prefix $prefix"
            ;;
          (track)
            _arguments \
              ":name:__git_flow_branch_names --type remotes --prefix '$origin/$prefix'"
            ;;
          (diff)
            _arguments \
              ":name:__git_flow_branch_names --prefix $prefix"
            ;;
          (rebase)
            _arguments \
              {-i,--interactive}'[do an interactive rebase]' \
              ":name:__git_flow_branch_names --prefix $prefix"
            ;;
          (checkout|co)
            _arguments \
              ":name:__git_flow_branch_names --prefix $prefix"
            ;;
          (pull)
            _arguments \
              ':remote:__git_any_repositories' \
              ":name:__git_flow_branch_names --prefix $prefix"
            ;;
        esac
        ;;
      esac
  }

  __git-flow-release () {
    local prefix=$(__git_flow_prefix "release")
    local origin="$(git config gitflow.origin 2> /dev/null || echo "origin")"

    local context state line
    typeset -A opt_args

    _arguments \
      ':command:->command' \
      '*::options:->options'
    case $state in
      (command)
        local -a commands

        commands=('list' 'start' 'finish' 'publish' 'track')
        _describe -t commands 'git flow release command' commands
        ;;
      (options)
        case $line[1] in
          (list)
            _arguments {-v,--verbose}'[verbose (more) output]'
            ;;
          (start)
            _arguments \
              {-F,--fetch}'[fetch from origin before performing local operation]' \
              ':version:__git_guard_branch-name'
            ;;
          (finish)
            _arguments \
              {-F,--fetch}'[fetch from origin before performing finish]' \
              {-s,--sign}'[sign the release tag cryptographically]' \
              {-u,--signingkey}'[use the given GPG-key for the digital signature (implies -s)]' \
              {-m,--message}'[use the given tag message]' \
              {-p,--push}'[push to origin after performing finish]' \
              {-k,--keep}'[keep branch after performing finish]' \
              {-n,--notag}"[don't tag this release]" \
              ":version:__git_flow_branch_names --prefix $prefix"
            ;;
          (publish)
            _arguments \
              ":version:__git_flow_branch_names --prefix $prefix"
            ;;
          (track)
            _arguments \
              ":version:__git_flow_branch_names --type remotes --prefix $prefix"
            ;;
        esac
        ;;
    esac
  }

  __git-flow-hotfix () {
    local prefix=$(__git_flow_prefix "hotfix")

    local context state line
    typeset -A opt_args

    _arguments \
      ':command:->command' \
      '*::options:->options'
    case $state in
      (command)
        local -a commands

        commands=('list' 'start' 'finish')
        _describe -t commands 'git flow hotfix command' commands
        ;;
      (options)
        case $line[1] in
          (list)
            _arguments {-v,--verbose}'[verbose (more) output]'
            ;;
          (start)
            _arguments \
              {-F,--fetch}'[fetch from origin before performing local operation]' \
              ':version:__git_guard_branch-name' \
              '::base:__git_revisions'
            ;;
          (finish)
            _arguments \
              {-F,--fetch}'[fetch from origin before performing finish]' \
              {-s,--sign}'[sign the release tag cryptographically]' \
              {-u,--signingkey}'[use the given GPG-key for the digital signature (implies -s)]' \
              {-m,--message}'[use the given tag message]' \
              {-p,--push}'[push to origin after performing finish]' \
              {-k,--keep}'[keep branch after performing finish]' \
              {-n,--notag}"[don't tag this release]" \
              ":version:__git_flow_branch_names --prefix $prefix"
            ;;
        esac
        ;;
    esac
    }

  __git-flow-support () {
    local prefix=$(__git_flow_prefix "support")

    local context state line
    typeset -A opt_args

    _arguments \
      ':command:->command' \
      '*::options:->options'
    case $state in
      (command)
        local -a commands

        commands=('list' 'start')
        _describe -t commands 'git flow support command' commands
        ;;
      (options)
        case $line[1] in
          (list)
            _arguments {-v,--verbose}'[verbose (more) output]'
            ;;
          (start)
            _arguments \
              {-F,--fetch}'[fetch from origin before performing local operation]' \
              ':version:__git_guard_branch-name' \
              '::base:__git_revisions'
            ;;
        esac
        ;;
    esac
  }

  # ----------------------------------------------------------------------------

  __git_flow_prefix () {
    case $1 in
      (feature|release|hotfix|support)
        git config "gitflow.prefix.$1" 2> /dev/null || echo "$1/"
        ;;
    esac
  }

  # taken and modified from zsh's git completion module
  #(( $+functions[__git_flow_branches] )) ||
  __git_flow_branch_names () {
    typeset -A opts
    opts[--type]="heads"
    zparseopts -A opts -E -D -K -- -type: -prefix:

    local expl
    typeset -a branch_names

    branch_names=(${${(f)"$(_call_program branchrefs git for-each-ref --format='"%(refname)"' refs/${opts[--type]}/${opts[--prefix]} 2>/dev/null)"}#refs/${opts[--type]}/${opts[--prefix]}})
    __git_command_successful || return

    _wanted branch-names expl branch-name compadd $* - $branch_names
  }
}
