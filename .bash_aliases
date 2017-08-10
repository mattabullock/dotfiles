alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list

alias grep='grep --color'

alias tmux='tmux -2'
alias nas='ssh nas@n.as'
alias lnas='ssh nas@ln.as'

alias ppytun='ssh -L 9999:localhost:8181 nas@n.as'
alias synctun='ssh -L 9999:localhost:8888 nas@n.as'
alias rttun='ssh -L 9999:localhost:9997 nas@n.as'
alias gltun='ssh -L 9999:localhost:9898 nas@n.as'
alias ndtun='ssh -L 9999:localhost:19999 nas@n.as'

alias seed='ssh nas@se.ed'

alias tmd="tmux new-session -d 'vim' && tmux split-window -v -p 18 && tmux attach-session -d"
alias auxg="ps aux | grep "
