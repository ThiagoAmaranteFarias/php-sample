FROM ubuntu:18.04

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update -y
RUN apt-get install apache2 -y
RUN apt-get install php7.2 php7.2-mbstring php7.2-curl php7.2-pgsql php7.2-xml php7.2-cli php7.2-common php7.2-fpm php7.2-json php7.2-opcache php7.2-readline php7.2-gd php7.2-soap nano vim -y
RUN apt install php-zip -y
RUN apt-get install git zip unzip cron -y
RUN a2enmod proxy_fcgi rewrite
RUN echo "America/Sao_Paulo" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

# Realiza a cópia do código fonte
COPY ./src/ /var/www/html

RUN cd /var/www/html

RUN find /var/www/html -type f -exec chmod 664 {} \;    
RUN find /var/www/html -type d -exec chmod 775 {} \;
RUN chmod 0777 /env.php /init.sh /bin/artisan /bin/composer /bin/quickstart
RUN chmod +x /usr/local/bin/wkhtmltoimage
RUN export TERM=xterm
EXPOSE 80
WORKDIR /var/www/html
CMD ["/init.sh"]
