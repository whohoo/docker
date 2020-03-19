#!/bin/sh

if [ ! -f /etc/samba/smb.conf ]; then
  cp /etc/smb.conf.default /etc/samba/smb.conf
fi

./add-smb-users.sh

smbd -i -F -S