#!/bin/sh -ev

DEFAULT_RVM_RUBY="ree-1.8.6"

export GEM_HOME="$HOME/.gem/ruby/1.8"

if [ ! -x $HOME/.rvm/scripts/rvm ]; then
  RVM_INSTALL=/tmp/rvm-install-latest-`date "+%Y%m%d%H%M%S"`
  curl http://rvm.beginrescueend.com/releases/rvm-install-latest -o $RVM_INSTALL
  chmod 700 $RVM_INSTALL
  $RVM_INSTALL
  rm -f $RVM_INSTALL
fi

if [ -L ~/.bash_profile ]; then
  rm ~/.bash_profile
fi
if [ ! -e ~/.bash_profile ]; then
  ln -s ~/projects/central_plexus/bash_profile ~/.bash_profile
fi
source ~/.bash_profile

rvm update --edge
rvm reload

if [ ! -d ~/.rvm/rubies/$DEFAULT_RVM_RUBY-*/ ]; then
  rvm install $DEFAULT_RVM_RUBY
fi
rvm $DEFAULT_RVM_RUBY --default

if [ ! -f ~/.gitconfig ]; then
  cp ~/projects/central_plexus/gitconfig ~/.gitconfig
fi

if [ -L ~/.gemrc ]; then
  rm ~/.gemrc
fi
if [ ! -e ~/.gemrc ]; then
  ln -s ~/projects/central_plexus/gemrc ~/.gemrc
fi

if [ ! -e ~/bin ]; then
  ln -s ~/projects/central_plexus/bin ~/
fi

if [ -L ~/.vimrc ]; then
  rm ~/.vimrc
fi
if [ ! -e ~/.vimrc ]; then
  ln -s ~/projects/central_plexus/vimrc ~/.vimrc
fi

if [ -L ~/.irbrc ]; then
  rm ~/.irbrc
fi
if [ ! -L ~/.irbrc ]; then
  ln -s ~/projects/central_plexus/irbrc ~/.irbrc
fi

if [ ! -e ~/.ackrc ]; then
  ln -s ~/projects/central_plexus/ackrc ~/.ackrc
else
  echo "~/.ackrc already exist"
fi

# setup dotmatrix
rvm rvmrc trust dotmatrix
cd dotmatrix
if [ -z "`which bundle 2>/dev/null`" ]; then
  gem install bundler
fi
bundle install
rake setup
cd ..
source ~/.shell_aliases

# Setup MacVim
~/bin/osx-macvim-bundle-setup
~/bin/osx-macvim-color-setup

# Mac OS X Dock setup
~/bin/osx-dock-remove-all-items
~/bin/osx-dock-autohide-enable
~/bin/osx-dock-glass-disable
~/bin/osx-dock-lock

# Mac OS X dashboard
~/bin/osx-dashboard-disable

# Mac OS X menubar setup
~/bin/osx-menubar-remove-all
sleep 2
~/bin/osx-menubar-enable-User

# AppliCage
cd AppliCage
./install.sh

port selfupdate
port upgrade outdated

# Install caged postgresql84-server
port install postgresql84-server +homedir
postgres_local_create_directory

PORTS="
git-core
htop
p5-app-ack
pbzip2
lzmautils
watch
wget
macvim
tmux
md5sha1sum
p5-crypt-ripemd160
links
"

echo "$PORTS" | while read line
do
  if [ -n "$line" ]
  then
    port install $line
  fi
done
