FROM ubuntu:16.04

RUN apt-get update

RUN apt-get install -y nginx

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections \
    && echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections \
    && apt-get install -y mysql-server

RUN chmod a+x /var/www/html

RUN mkdir venv

ADD start.sh /venv

WORKDIR /venv

RUN chmod a+x /venv/start.sh

ENTRYPOINT ["/venv/start.sh"]

EXPOSE 80

