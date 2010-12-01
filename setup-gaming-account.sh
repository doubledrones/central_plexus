#!/bin/sh -ev

if [ ! -e ~/bin ]; then
  ln -s ~/projects/central_plexus/bin ~/
fi

if [ ! -L ~/.bash_profile ]; then
  ln -s ~/projects/central_plexus/.bash_profile ~/
fi

source ~/.bash_profile

~/bin/osx-gaming-account
