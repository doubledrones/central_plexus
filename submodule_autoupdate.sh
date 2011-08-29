#!/bin/sh

cd `dirname $0`

git pull
if [ ! -d applicage/.git ]; then
  if [ -d applicage ]; then
    rm -rf applicage
  fi
  git clone git@github.com:/doubledrones/applicage.git
fi
if [ ! -d dotmatrix/.git ]; then
  if [ -d dotmatrix ]; then
    rm -rf dotmatrix
  fi
  git clone git@github.com:/doubledrones/dotmatrix.git
fi

cd applicage
git checkout master
git pull
cd ../dotmatrix
git checkout master
git pull
cd ..

case $1 in
  --push)
    git commit -a -m "Submodule autoupdate."
    git push
    ;;
esac
