#!/bin/sh -ev

APPLICAGE_VERSION="9bebf52"

export GEM_HOME="$HOME/.gem/ruby/1.8"

if [ ! -x $HOME/.rvm/scripts/rvm ]; then
  RVM_INSTALL=$GEM_HOME/bin/rvm-install
  if [ ! -x $RVM_INSTALL ]; then
    gem install rvm --verbose
  fi
  $RVM_INSTALL
fi

if [ ! -L ~/.bash_profile ]; then
  ln -s ~/projects/central_plexus/bash_profile ~/.bash_profile
fi
source ~/.bash_profile

rvm update --edge
rvm reload

rvm install ree-1.8.6
rvm ree-1.8.6 --default

if [ ! -f ~/.gitconfig ]; then
  cp ~/projects/central_plexus/gitconfig ~/.gitconfig
fi

if [ ! -L ~/.gemrc ]; then
  ln -s ~/projects/central_plexus/gemrc ~/.gemrc
fi

if [ ! -e ~/bin ]; then
  ln -s ~/projects/central_plexus/bin ~/
fi

if [ ! -L ~/.vimrc ]; then
  ln -s ~/projects/central_plexus/vimrc ~/.vimrc
fi

if [ ! -L ~/.irbrc ]; then
  ln -s ~/projects/central_plexus/irbrc ~/.irbrc
fi

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

# ACK setup
~/bin/ack-setup

# AppliCage
if [ ! -d ~/projects/AppliCage ]; then
  cd ~/projects
  curl http://download.github.com/doubledrones-AppliCage-$APPLICAGE_VERSION.tar.gz | tar xvfz -
  mv doubledrones-AppliCage-$APPLICAGE_VERSION AppliCage
  cd AppliCage
  ./install.sh
fi

# Install caged postgresql84-server
port install postgresql84-server +homedir
