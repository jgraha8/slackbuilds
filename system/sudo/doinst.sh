#!/bin/sh
config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}
config etc/sudoers.new
config etc/pam.d/sudo.new

# Ensure that there is an /etc/environment file to prevent "sudo -i"
# from complaining:
if [ ! -r etc/environment ]; then
  touch etc/environment
fi
