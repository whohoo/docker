#https://hub.docker.com/r/stanback/alpine-samba/dockerfile

FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
 && apk add --no-cache samba 
RUN cp /etc/samba/smb.conf /etc/smb.conf.default

ADD ./docker-entrypoint.sh ./add-smb-users.sh  /


VOLUME ["/var/log/"]

EXPOSE 445/tcp

CMD /docker-entrypoint.sh
#CMD top