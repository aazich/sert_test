FROM php:7.4-fpm
RUN apt-get update
RUN docker-php-ext-install pdo pdo_mysql mysqli
ADD php.ini /usr/local/etc/php/conf.d/40-custom.ini
WORKDIR /var/www
CMD ["php-fpm"]
