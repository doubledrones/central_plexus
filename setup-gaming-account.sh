#!/bin/sh

ln -s ~/projects/central_plexus/.bash_profile ~/
source ~/.bash_profile

if [ ! -e ~/bin ]; then
  ln -s ~/projects/central_plexus/bin ~/
fi

~/bin/osx-gaming-account

