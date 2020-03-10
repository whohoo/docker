# vsftpd
### Usage:
1. donwload code `git@github.com:whohoo/docker.git`
2. `cd ./vsftpd`
3. edit `./config/users.txt` add your ftp username and password
4. edit `./docker-compose.yml` add your ftp local path in `volumes`
5. run in command `docker-compose up -d --build`

When first run the container, it would genrate a `vsftpd.conf` file in `./config/` folder. You can change your vsfptd's configuration and dont' forget to restart the container.

### About the `./config/users.txt`

`ftp_name:ftp_password:/path_in_container:uid:gid`

1. `ftp_name`: the ftp user name (required)
2. `ftp_password`: the ftp user password (required)
3. `/path_in_container`: opional, if not specify, the default value is `/home/${ftp_name}`
4. `uid`: optional, your can specify the user's uid, the uid should be unique.
5. `gid`: optional, your can specify the group's gid. the default value is 100 [users group]

### Lock some user
##### To lock:
`docker-compose exec vsftpd passwd -l XXXXX`  

**XXXXX** should be replace with your `ftp_name` 

##### To unlock:
`docker-compose exec vsftpd passwd -u XXXXX`

### In China
Sometime it can't fetch anything, when run `apk add` in Apline. In that case, you need change `./Dcokerfile` file. please see below:  

```
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && apk add --no-cache vsftpd \
  && ...
```