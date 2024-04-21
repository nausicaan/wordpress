FROM php:8.2-fpm

# Declare the base Composer version
ENV COMPOSER_ROOT_VERSION='2.7.2'

# Create a non-root user
RUN useradd -m -d /home/des -s /bin/bash -g root -G sudo -u 1001 des

# PHP Core and WordPress extensions
RUN apt-get update && apt-get install -y \
		libfreetype-dev \
		libjpeg62-turbo-dev \
		zip libzip-dev \
		libpng-dev \
		libicu-dev \
		libmagickwand-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd mysqli pdo pdo_mysql zip \
	&& docker-php-ext-install exif \
	&& docker-php-ext-install intl \
	&& pecl install imagick \
	&& docker-php-ext-enable imagick

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# Install Composer
COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

# Set the working directory
WORKDIR /usr/share/nginx/html

# Switch to the DES user
USER des