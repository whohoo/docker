#!/bin/sh

uidindex=10001
namelist=""

for line in `cat /etc/samba/users.txt`; do
  username=`echo $line | cut -f 1 -d ":"`
  password=`echo $line | cut -f 2 -d ":"`
  
  if [ ! -z "$username" -a ! -z "$password" ]; then
    homepath=`echo $line | cut -f 3 -d ":"`
    
    if [ -z "$homepath" ]; then
      homepath="/home/$username"
    fi

    id $username >& /dev/null
    if [ $? -ne 0 ]; then
       uid_def=`echo $line | cut -f 4 -d ":"`
       if [  -z $uid_def ]; then
         let uidindex++
         uid_def=$uidindex
       fi

       
       gid_def=`echo $line | cut -f 5 -d ":"`
       if [ -z $gid_def ]; then
         groupname="users"
       else
         for line2 in `cat /etc/group`; do
           gid=`echo $line2 | cut -f 3 -d ":"`
           if [ $gid_def -eq $gid ]; then
             found_groupname=`echo $line2 | cut -f 1 -d ":"`
             break
           fi
         done
         
         if [ -z $found_groupname ]; then
           groupname=$username
           addgroup -g $gid_def "$groupname"
         else
           groupname=$found_groupname
         fi
       fi
       # add system account
       adduser -h "$homepath" -s /bin/false -G "$groupname" -u $uid_def  -D "$username"
       echo "$username:$password" | chpasswd 1 > /dev/null
       # add samba account
       echo -e "$password\n$password" | pdbedit -a -t -u $username
       namelist="$namelist $username,"
       echo $namelist
    else
       echo "user '$username' is exist."
    fi
    
  fi
done

sed -i "s/valid users = mary fred/valid users = ${namelist%?}/" /etc/smb.conf.default