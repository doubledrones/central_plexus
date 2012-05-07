export TERM="xterm-256color"
export LC_CTYPE="en_US.UTF-8"

function pwd_mount_via_ssh() {
  CURRENT_PWD=`pwd -P`
  for SSH_MOUNTED in `mount | grep fuse4x | cut -f 3 -d " "`
  do
    case $CURRENT_PWD in
      $SSH_MOUNTED | $SSH_MOUNTED/ | $SSH_MOUNTED/*)
        return "yes"
        ;;
    esac
  done
}

# prompt containing git branch
function parse_git_branch {
  if [ -z "`pwd_mount_via_ssh`" ]; then
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /'
  fi
}
function timestamp {
  echo "<`date '+%Y-%m-%d %H:%M'`>"
}

PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \[\033[01;32m\]\$(timestamp)\[\033[01;34m\] \[\033[01;32m\]\$(parse_git_branch)\[\033[01;34m\]\$\[\033[00m\] "

# MacPorts
export PATH="$HOME/.macports/bin:$HOME/.macports/sbin:$PATH"
export MANPATH="/Users/`whoami`/.macports/share/man:$MANPATH"

# Postgresql 8.4 for building gems and dependent packages
export PATH="$HOME/.macports/lib/postgresql84/bin/:$PATH"

# Home directory binaries and scripts
export PATH="$HOME/bin:$PATH"

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

export RUBYOPT='rubygems'

if [ -e ~/.shell_aliases ]; then
  source ~/.shell_aliases
fi

ARCHFLAGS="-arch `build_arch`"

if [ -e ~/.bash_profile.local ]; then
  source ~/.bash_profile.local
fi

case `uname  -r` in
  11*) # Lion
    export CC=/usr/bin/gcc-4.2
    ;;
esac

export RUBYOPT="-ropenssl"
