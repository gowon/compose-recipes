FROM php:8-apache
RUN docker-php-ext-install mysqli \
    && docker-php-ext-enable mysqli
RUN a2enmod rewrite
# RUN a2enmod rewrite \
#     && a2enmod ssl \
#     && a2enmod socache_shmcb
RUN apt-get update && apt-get upgrade -y