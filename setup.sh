#!/bin/sh -ev

chmod 700 $HOME

D_R=`cd \`dirname $0\` ; pwd -P`

DEFAULT_RVM_RUBY="ruby-1.9.2"

export GEM_HOME="$HOME/.gem/ruby/1.8"

sh $D_R/rvm_install.sh

if [ -L ~/.bash_profile ]; then
  rm ~/.bash_profile
fi
if [ ! -e ~/.bash_profile ]; then
  ln -s ~/projects/central_plexus/bash_profile ~/.bash_profile
fi
source ~/.rvm/scripts/rvm

if [ ! -d ~/.rvm/rubies/$DEFAULT_RVM_RUBY-*/ ]; then
  rvm install $DEFAULT_RVM_RUBY
fi
rvm $DEFAULT_RVM_RUBY --default

for MY_RUBY_VERSION in ruby-1.8.7:p352 ruby-1.9.2:p290
do
  MY_RUBY_PATCH=`echo $MY_RUBY_VERSION | cut -f 2 -d :`
  MY_RUBY_VERSION=`echo $MY_RUBY_VERSION | cut -f 1 -d :`
  if [ ! -d ~/.rvm/rubies/$MY_RUBY_VERSION-$MY_RUBY_PATCH/ ]; then
    for RUBY_DIR in `ls -d ~/.rvm/rubies/$MY_RUBY_VERSION-*`
    do
      rvm uninstall `basename $RUBY_DIR`
    done
    rvm install $MY_RUBY_VERSION -C --enable-pthread
  fi
done

if [ ! -f ~/.gitconfig ]; then
  cp ~/projects/central_plexus/gitconfig ~/.gitconfig
fi

if [ -L ~/.gemrc ]; then
  rm ~/.gemrc
fi
if [ ! -e ~/.gemrc ]; then
  ln -s ~/projects/central_plexus/gemrc ~/.gemrc
fi

if [ ! -e ~/bin ]; then
  ln -s ~/projects/central_plexus/bin ~/
fi

if [ -L ~/.vimrc ]; then
  rm ~/.vimrc
fi
if [ ! -e ~/.vimrc ]; then
  ln -s ~/projects/central_plexus/vimrc ~/.vimrc
fi

if [ -L ~/.irbrc ]; then
  rm ~/.irbrc
fi
if [ ! -L ~/.irbrc ]; then
  ln -s ~/projects/central_plexus/irbrc ~/.irbrc
fi

if [ ! -e ~/.ackrc ]; then
  ln -s ~/projects/central_plexus/ackrc ~/.ackrc
else
  echo "~/.ackrc already exist"
fi

# setup dotmatrix
cd dotmatrix
rake setup
cd ..
source ~/.shell_aliases

# applicage
cd applicage
echo `git pull`
./install.sh
#port selfupdate
echo `port upgrade outdated` # run in sub-shell to ignore errors
port install git-core +svn
ln -sf $HOME/.macports/bin/git $HOME/bin/git

# Vim tmp directory
if [ ! -d ~/.vim/tmp ]; then
  mkdir -p ~/.vim/tmp
fi

function osx_release() {
  case `uname -r | cut -f 1 -d .` in
    11)
      echo "Lion"
      ;;
    10)
      echo "Snow Leopard"
      ;;
  esac
}

# Setup MacVim
$D_R/bin/osx-macvim-bundle-setup
$D_R/bin/osx-macvim-color-setup

# Mac OS X Dock setup
$D_R/bin/osx-dock-autohide-enable
$D_R/bin/osx-dock-glass-disable
echo `$D_R/bin/osx-dock-restart` # run in sub-shell to ignore errors

# Mac OS X menubar setup
echo `$D_R/bin/osx-menubar-remove-all` # run in sub-shell to ignore errors
sleep 2
echo `$D_R/bin/osx-menubar-enable-User` # run in sub-shell to ignore errors

# Mac OS X disable annoying Caps Lock
$D_R/bin/osx-capslock-disable

# Magic Mouse setup
$D_R/bin/osx-magic-mouse-two-button-enable

if [ -z "`osx_release | grep Lion`" ]; then
  # Disable annoying Front Row keystroke
  $D_R/bin/osx-frontrow-disable

  # Lock screen on sleep and screen saver
  $D_R/bin/osx-lock-screen-on-sleep-or-screen-saver
fi

# Install caged postgresql84-server
port install postgresql84-server +homedir

PORTS="
Alfred
Dropbox
1Password
iTerm2
KeyboardMaestro
Caffeine
TextMate
MindNode
Fluid
CCMenu

pkgconfig
autoconf
automake
libtool
libiconv
openssh

ossp-uuid
md5sha1sum
coreutils
pcre

axel
mtr
htop
p5-app-ack
pbzip2
watch
wget
macvim +ruby
tmux
p5-crypt-ripemd160
links
png2ico

aesutil
aescrypt
weex
pwgen
unrar

ncftp
xz
firefox-bin-pl
GitX
mongodb
"

gem install mongo

function is_laptop() {
  sysctl -n hw.model | grep "^MacBook"
}

if [ -n "`is_laptop`" ]; then
  PORTS="$PORTS NetworkLocation"
fi

echo "$PORTS" | while read line
do
  if [ -n "$line" ]
  then
    port install $line
  fi
done

echo `open ~/Applications/MacPorts/Alfred.app/` # run in sub-shell to ignore errors

# cleanup distfiles
rm -rf ~/.macports/var/macports/distfiles/
mkdir -p ~/.macports/var/macports/distfiles/

postgres_local_create_directory

if [ -n "`osx_release | grep Lion`" ]; then
  echo
  echo "You can also disable local time machine by: sudo tmutil disablelocal"
  echo
fi

echo
echo "If you have administrator account you can also install git-annex via: sh git-annex-install.sh"
echo
