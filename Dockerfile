FROM  phpearth/php:7.3-apache

RUN sed -i 's/128M/-1/g' /etc/php/7.3/php.ini
RUN apk update
RUN apk add --no-cache bash git curl openssh patch imagemagick
RUN apk add --no-cache php7-dev php7.3-gd php7.3-imagick php7.3-bz2 php7.3-pdo php7.3-pdo_mysql
RUN pecl install pcov
RUN echo 'extension=pcov.so' >> /etc/php/7.3/php.ini

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/httpd.conf
RUN sed -i '/LoadModule rewrite_module/s/^#//g' /etc/apache2/httpd.conf
RUN echo -e "\nServerName localhost\n" >> /etc/apache2/httpd.conf
RUN httpd -k restart

