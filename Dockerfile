FROM  phpearth/php:7.4-apache

RUN sed -i 's/128M/-1/g' /etc/php/7.4/php.ini
RUN apk update
RUN apk add --no-cache bash composer git curl openssh patch imagemagick
RUN apk add --no-cache php7-dev php7.4-gd php7.4-imagick php7.4-bz2 php7.4-pdo php7.4-pdo_mysql
RUN pecl install pcov
RUN echo 'extension=pcov.so' >> /etc/php/7.4/php.ini

RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/httpd.conf
RUN sed -i '/LoadModule rewrite_module/s/^#//g' /etc/apache2/httpd.conf
RUN echo -e "\nServerName localhost\n" >> /etc/apache2/httpd.conf
RUN httpd -k restart
