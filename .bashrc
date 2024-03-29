export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/opt/X11/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/opt/dirmngr/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin:~/.rbenv/bin" # Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.local/bin"


#export GPG_TTY="$(tty)"
#export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#gpgconf --launch gpg-agent

export HISTCONTROL=ignoredups:ignorespace
export EDITOR='vim'

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases
[ -f $HOME/.bash_nas_aliases ] && source $HOME/.bash_nas_aliases
[ -f $HOME/.bash_work_aliases ] && source $HOME/.bash_work_aliases
[ -f $HOME/.bash_git_aliases ] && source $HOME/.bash_git_aliases

#################
# Custom prompt #
#################
function parse_git_dirty {
    if ! git ls-files >& /dev/null; then
        echo ""
    else
        [[ $(git diff --shortstat) ]] && echo "*"
    fi
}

function get_branch_color {
    if ! git ls-files >& /dev/null; then
        echo ""
    else
        local dirty=$(parse_git_dirty)
        if [[ $dirty == '*' ]]
        then
            echo "\[\033[31m\]"
        else
            echo "\[\033[32m\]"
        fi
    fi
}

# Determine active Python virtualenv details.
function get_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      echo ""
  else
      echo "\[\e[00m\](\[\e[m\]\[\033[0;32m\]`basename \"$VIRTUAL_ENV\"`\[\e[00m\])\[\e[m\] "
  fi
}

function color_my_prompt {
    history -a
    local virtualenv=$(get_virtualenv)
    local branch_color=$(get_branch_color)
    local git_branch='`git branch 2> /dev/null | command grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\\\\\1\/`'
    local open_paren='\[\e[00m\](\[\e[m\]'
    local close_paren='\[\e[00m\])\[\e[m\]'
    local last_color="\[\033[00m\]"
    local prompt_symbol="$"
    export PS1="$virtualenv[\[\e[36m\]\u@\h\[\e[m\] \[\e[00m\]\w\[\e[m\]] $open_paren$branch_color$git_branch$close_paren $last_color"
}
PROMPT_COMMAND=color_my_prompt

# fzf config
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
