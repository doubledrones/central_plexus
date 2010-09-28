export TERM="xterm-256color"

# prompt containing git branch
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /'
}
PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \[\033[01;32m\]\$(parse_git_branch)\[\033[01;34m\]\$\[\033[00m\] "

# MacPorts
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# Ruby Version Manager
if [[ -s /Users/pr0d1r2/.rvm/scripts/rvm ]] ; then source /Users/pr0d1r2/.rvm/scripts/rvm ; fi

# git aliases
alias pm=".git/hooks/post-merge"
alias gpm="g .git/hooks/post-merge"
