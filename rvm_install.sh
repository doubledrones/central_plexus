#!/bin/sh -ev

if [ ! -x $HOME/.rvm/scripts/rvm ]; then
  RVM_INSTALL=/tmp/rvm-install-`date "+%Y%m%d%H%M%S"`
  curl https://rvm.beginrescueend.com/install/rvm -o $RVM_INSTALL -k
  chmod 700 $RVM_INSTALL
  $RVM_INSTALL $@
  rm -f $RVM_INSTALL
fi
