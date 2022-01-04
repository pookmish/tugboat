FROM tugboatqa/php:7-apache

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
RUN apt-get update && apt-get install bash git curl patch libmagickwand-dev libzip-dev zip -y
RUN pecl install imagick
RUN docker-php-ext-enable imagick
RUN docker-php-ext-install gd bz2 pdo zip
RUN pecl install pcov
RUN echo 'extension=pcov.so' >> /usr/local/etc/php/php.ini

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN sed -i 's/128M/-1/g' /usr/local/etc/php/php.ini

RUN a2enmod rewrite
RUN echo "\nServerName localhost\n" >> /etc/apache2/apache2.conf
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
RUN apache2ctl configtest
RUN apache2ctl restart
