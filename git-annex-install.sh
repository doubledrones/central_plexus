#!/bin/sh

#Install Haskel Platform from http://hackage.haskell.org/platform/mac.html. The version provided by Macports is too old to work with current versions of git-annex. Then execute

port install git-core ossp-uuid md5sha1sum coreutils pcre

sudo ln -s ~/.macports/include/pcre.h  /usr/include/pcre.h # This is hack that allows pcre-light to find pcre

# optional: this will enable the gnu tools, (to give sha224sum etc..., it does not override the BSD userland)
export PATH="$PATH:$HOME/.macports/libexec/gnubin"

# this allow cabal to see right version of git
export PATH="$HOME/.macports/bin:$PATH"

sudo cabal update
cabal install git-annex --bindir=$HOME/bin
