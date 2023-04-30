FROM ubuntu:18.04

WORKDIR /app

RUN apt update \
	&& apt install -y apache2 apache2-utils \
	&& apt clean
RUN a2enmod dav*

ADD webdav.conf /etc/apache2/sites-available/webdav.conf
ADD entrypoint.sh /app

RUN a2ensite webdav

CMD /app/entrypoint.sh
