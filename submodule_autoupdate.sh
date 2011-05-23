#!/bin/sh

cd `dirname $0`

cd applicage
git pull
cd ../dotmatrix
git pull
cd ..

case $1 in
  --push)
    git commit -a -m "Submodule autoupdate."
    git push
    ;;
esac
