# Samba
### Usage:
1. donwload code `git@github.com:whohoo/docker.git`
2. `cd ./samba`
3. edit `./config/users.txt` add your ftp username and password
4. edit `./docker-compose.yml` add your ftp local path in `volumes`
5. run in command `docker-compose up -d --build`

When first run the container, it would genrate a `smb.conf` file in `./config/` folder. You can change your samba's configuration and dont' forget to restart the container.

### About the `./config/users.txt`

`username:password:/path_in_container:uid:gid`

1. `username`: the ftp user name (required)
2. `password`: the ftp user password (required)
3. `/path_in_container`: opional, if not specify, the default value is `/home/${username}`, 
4. `uid`: optional, your can specify the user's uid, the uid should be unique.
5. `gid`: optional, your can specify the group's gid. the default value is 100 [users group]

### About [smb.conf](https://www.samba.org/samba/docs/current/man-html/smb.conf.5.html)
共享文件夹配置说明:

```
[myShare]
   comment = 这里是备注, 当hover在共享目录上时, 显示备注
   path = /share/user1
   browseable = yes
   valid users = test2, wally, @wally
   guest ok = no
   writable = yes
   write list = wally,test2
   create mask = 0765
```
- **`path`**: 这里是指docker里的路径, 在docker-compose.yml中指定`volumes`来映射到本地系统路径
- **`browseable `**: 当值为`no`的时候, 共享目录不可见, 但可通过`\\xxx.xxx.xxx.xxx\myShare`的方式直接访问, 默认为`yes`
- **`guest ok`** or **`public`**: 值`yes|no`, 当为yes的时候, 可通过访客账号访问共享目录
- **`valid users`**: 默认为空, 表示所有用户都有权限访问, 指定用户用逗号分隔, 可以用`@组名`的方式来添加组用户
- **`writable`**: `yes`当前目录是否可写入, 默认为`no`
- **`write list`**: 给于指定用户读写权限, 
- **`create mask`** or **`directory mask`**: 用户新建的文件或目录所拥有的文件权限
- **`available`**: 是否启用共享目录, `yes|no`

## **注**: 

1. 除了要指定`writable`, `write list`等属性外, unix文件用户权限也同样需要同等的相应的权限方可访问与读写
2. 除了需要在docker容器中添加用户外`adduser`, 还需要通过`smbpasswd `或`pdbedit`添加用户, 也就是说samba里的用户需要在系统里有对应的用户
3. Samba 4.7(Alpine 3.7) 版本可运行`smb -F -S`没问题, Samba 4.8(Alpine 3.8)版本后, 一定要加上参数**`-i`**, 如`smbd -i -F -S`, 如果省去-i参数, 则smb会弹出`exit_daemon: daemon failed to start: Failed to create session, error code 1`错误提示. 但加上**`-i`**参数后, 非windows系统无法连上共享服务器, 现在的解决方式是运行`smbd` 不带任何参数, 然后加上 `while true; do sleep 1000; done` 这命令让程序持续执行. 否则docker container会因为命令执行完成退出. 
4. 如果不喜欢上述的解决方式, 可以修改`Dockerfile`文件第三行, 修改为`FROM alpine:3.7` , 然后修改`docker-entrypoint.sh`文件, 把`smdb` 加上参数, 如:`smdb -F  -S`, 再把`while true; do sleep 1000; done`这代码删除就可以了.


### Lock some user
##### To lock:
`docker-compose exec samba smbpasswd -d XXXXX`  

**XXXXX** should be replace with your `username` 

##### To unlock:
`docker-compose exec samba smbpasswd -e XXXXX`

### In China
Sometime it can't fetch anything, when run `apk add` in Apline. In that case, you need change `./Dcokerfile` file. please see below:  

```
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && apk add --no-cache vsftpd \
  && ...
```

