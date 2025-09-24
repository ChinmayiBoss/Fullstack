FROM php:8.2-apache

# Install dependencies for building MongoDB PHP extension
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libcurl4-openssl-dev \
    libz-dev \
    pkg-config \
    unzip \
    git \
    gcc \
    g++ \
    make \
    autoconf \
    libc-dev \
    && rm -rf /var/lib/apt/lists/*

# Install MongoDB extension
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

# Enable Apache rewrite
RUN a2enmod rewrite

# Copy project files
COPY . /var/www/html/
WORKDIR /var/www/html/

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install PHP dependencies
RUN composer install --ignore-platform-req=ext-mongodb
