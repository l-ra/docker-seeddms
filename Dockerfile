FROM php:7.0-apache
MAINTAINER Ludwig Prager <ludwig.prager@celp.de>

RUN apt update && \
   apt  install -y locales && \
   apt install -q -y software-properties-common && \
   LANG=C.UTF-8  LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && \
   LANG=C.UTF-8  LC_ALL=C.UTF-8 apt update && \
   LANG=C.UTF-8  LC_ALL=C.UTF-8 apt install -q -y libpng-dev imagemagick
# RUN apt update 
# RUN apt  install -q -y language-pack-en-base
# RUN locale-gen C.UTF-8
# RUN apt install -q -y software-properties-common 
# RUN LANG=C.UTF-8  LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php 
# RUN LANG=C.UTF-8  LC_ALL=C.UTF-8 apt update 
# RUN LANG=C.UTF-8  LC_ALL=C.UTF-8 apt install -q -y libpng-dev imagemagick

RUN docker-php-ext-install gd

RUN apt-get install -q -y php7.0-gd php7.0-sqlite poppler-utils catdoc

ADD misc/seeddms-quickstart-5.0.5.tar.gz /var/www/

RUN a2enmod rewrite

COPY misc/php.ini /usr/local/etc/php/
COPY misc/000-default.conf /etc/apache2/sites-available/

COPY misc/settings.xml /var/www/seeddms50x/seeddms-5.0.5/conf/settings.xml
RUN chown -R www-data:www-data /var/www/seeddms50x/

RUN touch /var/www/seeddms50x/seeddms-5.0.5/conf/ENABLE_INSTALL_TOOL
