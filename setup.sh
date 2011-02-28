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

for MY_RUBY_VERSION in ree-1.8.6:20090610 ruby-1.8.7:p334 ruby-1.9.2:p180
do
  MY_RUBY_PATCH=`echo $MY_RUBY_VERSION | cut -f 2 -d :`
  MY_RUBY_VERSION=`echo $MY_RUBY_VERSION | cut -f 1 -d :`
  if [ ! -d ~/.rvm/rubies/$MY_RUBY_VERSION-$MY_RUBY_PATCH/ ]; then
    if [ -d ~/.rvm/rubies/$MY_RUBY_VERSION-*/ ]; then
      rvm uninstall $MY_RUBY_VERSION
    fi
    rvm install $MY_RUBY_VERSION -C --enable-pthread
  fi
done

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

# Install caged postgresql84-server
port install postgresql84-server +homedir

PORTS="
pkgconfig
autoconf
automake
libtool
libiconv
openssh

htop
p5-app-ack
pbzip2
lzmautils
watch
wget
macvim +ruby
tmux
md5sha1sum
p5-crypt-ripemd160
links
iTerm
Things
aesutil
aescrypt
weex
"

echo "$PORTS" | while read line
do
  if [ -n "$line" ]
  then
    port install $line
  fi
done

sudo $HOME/.macports/bin/port install -f macfuse Growl
port install sshfs

postgres_local_create_directory
