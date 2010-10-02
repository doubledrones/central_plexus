#!/bin/sh

rvm-install

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
