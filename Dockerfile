FROM php:8.3-apache

RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    zip \
    unzip \
    curl \
    git \
    mariadb-client \
    pkg-config \
    g++ \
    make \
    autoconf

    RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
 && docker-php-ext-install -j$(nproc) \
     mysqli \
    gd \
    intl \
    zip \
    mbstring \
    xml \
    opcache \
    pdo_mysql

    RUN a2enmod rewrite headers env