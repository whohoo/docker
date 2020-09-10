FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && apk add --no-cache vsftpd \
  && sed -i "s/#write_enable=YES/write_enable=YES/" /etc/vsftpd/vsftpd.conf \
  && sed -i "s/anonymous_enable=YES/anonymous_enable=NO/" /etc/vsftpd/vsftpd.conf \
  && sed -i "s/#local_enable=YES/local_enable=YES/" /etc/vsftpd/vsftpd.conf \
  && sed -i "s/#chroot_local_user=YES/chroot_local_user=YES/" /etc/vsftpd/vsftpd.conf \
  && sed -i "s/#local_umask=022/local_umask=022/"  /etc/vsftpd/vsftpd.conf \
  && echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf \
  && echo "passwd_chroot_enable=YES" >> /etc/vsftpd/vsftpd.conf \
  && echo 'seccomp_sandbox=NO' >> /etc/vsftpd/vsftpd.conf \
  && echo 'pasv_enable=NO' >> /etc/vsftpd/vsftpd.conf \
  && echo 'pasv_max_port=10100' >> /etc/vsftpd/vsftpd.conf \
  && echo 'pasv_min_port=10090' >> /etc/vsftpd/vsftpd.conf \
  && cp /etc/vsftpd/vsftpd.conf /etc/vsftpd.conf.default

COPY docker-entrypoint.sh add-ftp-users.sh /

VOLUME [ "/var/log/", "/home/"]


ENTRYPOINT [ "/docker-entrypoint.sh" ] 
