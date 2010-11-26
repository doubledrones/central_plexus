#!/bin/sh

cd `dirname $0`

if [ ! -f /sbin/mount_ntfs.orig ]; then
  sudo mv -v /sbin/mount_ntfs /sbin/mount_ntfs.orig
  sudo cp -v mount_ntfs /sbin/mount_ntfs
fi
