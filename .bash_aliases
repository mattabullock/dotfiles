alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list

if [ -x "$(command -v ag)" ]; then
    alias grep='ag'
else
    alias grep='grep --color -i'
fi

alias tmux='tmux -2'
alias nas='ssh nas@n.as'
alias lnas='ssh nas@ln.as'
alias seed='ssh nas@se.ed'
