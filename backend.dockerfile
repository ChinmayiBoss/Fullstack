FROM php:8.2-apache

# Set working directory first
WORKDIR /var/www/html/

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

# Install MongoDB PHP extension
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

# Enable Apache rewrite
RUN a2enmod rewrite

# Install Composer directly (no multi-stage needed)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy project files
COPY . .

# Install PHP dependencies
RUN composer install --ignore-platform-req=ext-mongodb

# Expose Apache port
EXPOSE 80

# Default command
CMD ["apache2-foreground"]
