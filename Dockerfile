FROM php:8.1-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    cron \
    git

# PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd pdo pdo_pgsql zip

# Apache config
COPY apache.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Set working dir
WORKDIR /var/www/html

# Copy ILIAS
COPY ilias /var/www/html

# Permissions
RUN chown -R www-data:www-data /var/www/html \
 && chmod -R 755 /var/www/html

EXPOSE 80
