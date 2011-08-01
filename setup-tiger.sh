
#!/bin/sh -ev

D_R=`cd \`dirname $0\` ; pwd -P`

DEFAULT_RVM_RUBY="ruby-1.9.2"

export GEM_HOME="$HOME/.gem/ruby/1.8"

RVM_VERSION="1.6.32"

if [ ! -x $HOME/.rvm/scripts/rvm ]; then
  RVM_DOWNLOAD_URL="https://rvm.beginrescueend.com/releases"

  curl -B -L -k $RVM_DOWNLOAD_URL/rvm-${RVM_VERSION}.tar.gz.md5 -o /tmp/rvm-${RVM_VERSION}.tar.gz.md5
  curl -B -L -k $RVM_DOWNLOAD_URL/rvm-${RVM_VERSION}.tar.gz -o /tmp/rvm-${RVM_VERSION}.tar.gz
  cd /tmp
  md5 /tmp/rvm-${RVM_VERSION}.tar.gz
  if [ $? -gt 0 ]; then
    echo "Problem with source download"
    exit 1
  fi
  if [ ! -d $HOME/.rvm/src ]; then
    mkdir -p $HOME/.rvm/src
  fi
  tar xfz rvm-${RVM_VERSION}.tar.gz -C $HOME/.rvm/src
  mv $HOME/.rvm/src/rvm-${RVM_VERSION} $HOME/.rvm/src/rvm
  rm /tmp/rvm-${RVM_VERSION}.tar.gz.md5
  rm /tmp/rvm-${RVM_VERSION}.tar.gz
  cd $HOME/.rvm/src/rvm
  cp scripts/install scripts/install.tiger
  cat scripts/install | \
    sed -e '6s/^/#/g' | \
    sed -e '9,14s/^/#/g' | \
    cat > scripts/install.tiger
  mv scripts/install.tiger scripts/install
  ./scripts/install --prefix "$HOME" --path "$HOME/.rvm"
fi

export MACOSX_DEPLOYMENT_TARGET="10.4"

source ~/.rvm/scripts/rvm

if [ ! -d ~/.rvm/rubies/$DEFAULT_RVM_RUBY-*/ ]; then
  rvm install $DEFAULT_RVM_RUBY
fi
rvm $DEFAULT_RVM_RUBY --default

rvm reload

gem install flog

port install iTermTiger
port install 1Password2
port install p5-app-ack
port install MacVimTiger
port install md5sha1sum
port install p5-crypt-ripemd160
port install sshfsTiger
port install CaffeineTiger
port install Shimo
port install ThingsTiger
