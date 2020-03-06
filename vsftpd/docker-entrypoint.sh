#!/bin/sh


if [ ! -f /etc/vsftpd/vsftpd.conf ]; then
  cp /etc/vsftpd.conf.default /etc/vsftpd/vsftpd.conf
fi

./add-ftp-users.sh

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
