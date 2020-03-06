#!/bin/sh

uidindex=2000

for line in `cat /etc/vsftpd/users.txt`

do
  username=`echo $line | cut -f 1 -d ":"`
  password=`echo $line | cut -f 2 -d ":"`
  
  if [ ! -z "$username" -a ! -z "$password" ]; then
    homepath=`echo $line | cut -f 3 -d ":"`
    if [ -z "$homepath" ]; then
      homepath="/home/$username"
    fi

    id $username >& /dev/null
    if [ $? -ne 0 ]; then
       uid=`echo $line | cut -f 4 -d ":"`
       if [  -z $uid ]; then
         uidindex=`expr $uidindex + 1`
         uid=$uidindex
       fi
       adduser -h $homepath -s /bin/false -G users -u $uid  -D $username
       echo "$username:$password" | chpasswd
    else
       echo "user '$username' is exist."
    fi
    
  fi
done
