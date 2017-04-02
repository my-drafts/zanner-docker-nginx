FROM progrium/busybox:latest

MAINTAINER Sergyi Kukharyev <sergej.kucharev@gmail.com>

ARG user=nginx
ARG group=${user}
RUN adduser -s /bin/false -D ${user} ${group}

RUN opkg-install opkg && opkg update
RUN opkg install vim
RUN opkg install htop

RUN opkg install nginx
COPY docker/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -pv -m a+r,a+x,u+w /var/log/nginx/ /var/lib/nginx/
COPY data /data
RUN chmod -R a+r,a+w,a+x /data

RUN mkdir -pv -m a+r,a+x,u+w /docker
COPY docker/*.sh /docker/
RUN chmod -R +x /docker/*.sh

ENTRYPOINT ["/docker/enterpoint.sh"]
EXPOSE 80
