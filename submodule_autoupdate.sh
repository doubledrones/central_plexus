#!/bin/sh

cd `dirname $0`

git pull
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
