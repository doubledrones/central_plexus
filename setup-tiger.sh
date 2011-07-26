
#!/bin/sh -ev

D_R=`cd \`dirname $0\` ; pwd -P`

DEFAULT_RVM_RUBY="ruby-1.9.2"

export GEM_HOME="$HOME/.gem/ruby/1.8"

if [ ! -x $HOME/.rvm/scripts/rvm ]; then
  RVM_INSTALL=/tmp/rvm-install-`date "+%Y%m%d%H%M%S"`
  curl https://rvm.beginrescueend.com/install/rvm -k | \
    sed -e '6s/^/#/g' | \
    sed -e '166,170s/^/#/g' | \
    cat > $RVM_INSTALL
  chmod 700 $RVM_INSTALL
  $RVM_INSTALL --version latest
  rm -f $RVM_INSTALL
  cd $HOME/.rvm/src
  cd `ls`
  cp scripts/install scripts/install.tiger
  cat scripts/install | \
    sed -e '6,13s/^/#/g' | \
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
port install Things
