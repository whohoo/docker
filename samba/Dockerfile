#https://hub.docker.com/r/stanback/alpine-samba/dockerfile

FROM alpine:3.11

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
 && apk add --no-cache samba-server samba-common-tools \
 && sed -i "s/workgroup = MYGROUP/workgroup = WORKGROUP/" /etc/samba/smb.conf \
 && sed -i "s/server string = Samba Server/server string = %h server (Samba, Alpine)/" /etc/samba/smb.conf \
 && sed -i "s/#============================ Share Definitions /   security = user\n   map to guest = Bad User\n   load printers = no\n   printcap name = \/dev\/null\n   disable spoolss = yes\n   disable netbios = yes\n   server services = -dns, -nbt\n   smb ports = 445\n;  name resolve order = hosts\n;  log level = 3\n\n\n&/" /etc/samba/smb.conf \
 && sed -i "s/\[homes\]/&\n   available = no/" /etc/samba/smb.conf \ 
 && cp /etc/samba/smb.conf /etc/smb.conf.default

ADD ./docker-entrypoint.sh ./add-smb-users.sh  /


EXPOSE 445/tcp

CMD /docker-entrypoint.sh
#CMD top