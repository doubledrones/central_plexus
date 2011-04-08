#!/bin/sh -ev

DEFAULT_RVM_RUBY="ruby-1.9.2"

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
rvm gemset create 'dotmatrix'
cd dotmatrix
if [ -z "`which bundle 2>/dev/null | grep -v '/usr/bin/bundle'`" ]; then
  gem install bundler
fi
bundle install
rake setup
cd ..
source ~/.shell_aliases

# applicage
cd applicage
./install.sh
port selfupdate
echo `port upgrade outdated` # run in sub-shell to ignore errors
port install git-core

# Vim tmp directory
if [ ! -d ~/.vim/tmp ]; then
  mkdir -p ~/.vim/tmp
fi

# Setup MacVim
~/bin/osx-macvim-bundle-setup
~/bin/osx-macvim-color-setup

# Mac OS X Dock setup
echo `~/bin/osx-dock-remove-all-items` # run in sub-shell to ignore errors
~/bin/osx-dock-autohide-enable
~/bin/osx-dock-glass-disable
~/bin/osx-dock-lock
~/bin/osx-dock-restart

# Mac OS X menubar setup
~/bin/osx-menubar-remove-all
sleep 2
~/bin/osx-menubar-enable-User


PORTS="
uTorrent
TVShows
jDownloader
"

echo "$PORTS" | while read line
do
  if [ -n "$line" ]
  then
    port install $line
  fi
done

# cleanup distfiles
rm -rf ~/.macports/var/macports/distfiles/
mkdir -p ~/.macports/var/macports/distfiles/
