#!/bin/sh

RVM_INSTALL=$HOME/.gem/ruby/1.8/bin/rvm-install
if [ ! -x $RVM_INSTALL ]; then
  gem install rvm
fi
$RVM_INSTALL

ln -s ~/projects/central_plexus/.bash_profile ~/
source ~/.bash_profile

rvm update --edge
rvm reload

cp ~/projects/central_plexus/.gitconfig ~/
echo "git config user.name:"
read GIT_NAME
echo "git config user.email:"
read GIT_EMAIL
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

ln -s ~/projects/central_plexus/.gemrc ~/

if [ ! -e ~/bin ]; then
  ln -s ~/projects/central_plexus/bin ~/
fi

ln -s ~/projects/central_plexus/.vimrc ~/

# menubar icons with empty one for minimalist desktop
~/bin/osx-menubar-hide-dropbox
~/bin/osx-menubar-hide-airfoil-speakers
~/bin/osx-menubar-hide-shimo
~/bin/osx-menubar-hide-ccmenu

# Setup MacVim
~/bin/osx-macvim-bundle-setup
~/bin/osx-macvim-color-setup

# Mac OS X Dock setup
~/bin/osx-dock-remove-all-items

# Mac OS X menubar setup
~/bin/osx-menubar-remove-all

# ACK setup
~/bin/ack-setup

