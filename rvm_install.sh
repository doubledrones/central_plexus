#!/bin/bash -ev

if [ ! -x $HOME/.rvm/scripts/rvm ]; then
  curl -L get.rvm.io | bash -s stable
fi
