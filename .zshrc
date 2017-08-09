if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# User configuration

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/MacGPG2/bin:$PATH"
export PATH="/opt/X11/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/opt/dirmngr/bin:$PATH"

export GOPATH=$HOME/projects/golang

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

export GPG_TTY=$(tty)
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
fi

[ -f $HOME/.zsh_aliases ] && source $HOME/.zsh_aliases
[ -f $HOME/.zsh_nas_aliases ] && source $HOME/.zsh_nas_aliases
[ -f $HOME/.zsh_work ] && source $HOME/.zsh_work
[ -f $HOME/.zsh_work_aliases ] && source $HOME/.zsh_work_aliases

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export HISTCONTROL=ignoreboth:erasedups

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

function pr(){
    remote=`git remote -v | grep origin | head -1 | awk '{print $2}' | sed 's/.*:\(.*\)*/\1/' | sed 's/\.git$//'`
    branch=`git rev-parse --abbrev-ref HEAD`
    open "https://github.com/$remote/compare/${1:-master}...$branch?expand=1"
}
