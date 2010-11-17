#!/bin/sh -ev

GIT_NAME="Gall Anonymous"
GIT_EMAIL="gall.anonymous@gmail.com"

PLEXUS="$HOME/projects/central_plexus"
MACPORTS="$HOME/.macports"
GIT="$MACPORTS/bin/git"

cd $PLEXUS

if [ ! -d $MACPORTS ]; then
  bin/macports-install
fi

export PATH="$MACPORTS/bin:$PATH"

if [ ! -x $GIT ]; then
  bin/macports-install-core
fi

$GIT pull

$GIT config --global user.name "$GIT_NAME"
$GIT config --global user.email "$GIT_EMAIL"

cd ..

source ~/.bash_profile

# ~/.ssh/sync_private_projects.sh # example
