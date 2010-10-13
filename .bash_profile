export TERM="xterm-256color"
export LC_CTYPE="UTF-8"

# prompt containing git branch
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /'
}
PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \[\033[01;32m\]\$(parse_git_branch)\[\033[01;34m\]\$\[\033[00m\] "

# MacPorts
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# Postgresql 8.4 for building gems and dependent packages
export PATH="/opt/local/lib/postgresql84/bin:$PATH"

# Home directory binaries and scripts
export PATH="~/bin:$PATH"

# Ruby Version Manager
if [[ -s /Users/`whoami`/.rvm/scripts/rvm ]] ; then source /Users/`whoami`/.rvm/scripts/rvm ; fi

# git aliases
alias pm=".git/hooks/post-merge"
alias gpm="g .git/hooks/post-merge"

# rails aliases
alias migrate="rake db:migrate && rake db:test:clone"
alias remigrate="rake db:migrate && rake db:migrate:redo && rake db:test:clone"
alias dbfromscratch="rake db:drop && rake db:create && rake db:migrate && rake db:test:clone"
alias sj="rake specjour"
alias sjc="rake specjour:cucumber"
alias sji="infinite rake specjour"
alias sjci="infinite rake specjour:cucumber"
alias cucumberi="infinite cucumber"
