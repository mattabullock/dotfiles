export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/MacGPG2/bin:$PATH"
export PATH="/opt/X11/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/opt/dirmngr/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export GOPATH=$HOME/projects/golang

# use Ctrl-Z to fg (still does bg on vim)
stty susp undef
bind -x '"\C-z": "fg"'

export GPG_TTY=$(tty)
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
fi

export HISTCONTROL=ignoredups:ignorespace
export EDITOR='vim'

# added by travis gem
[ -f /Users/mattbullock/.travis/travis.sh ] && source /Users/mattbullock/.travis/travis.sh

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

function color_my_prompt {
    history -a
    local branch_color=$(get_branch_color)
    local git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\\\\\1\/`'
    local open_paren='\[\e[00m\](\[\e[m\]'
    local close_paren='\[\e[00m\])\[\e[m\]'
    local last_color="\[\033[00m\]"
    local prompt_symbol="$"
    export PS1="[\[\e[36m\]\u@\h\[\e[m\] \[\e[00m\]\w\[\e[m\]] $open_paren$branch_color$git_branch$close_paren$last_color "
}
PROMPT_COMMAND=color_my_prompt
