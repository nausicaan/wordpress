FROM php:8.2-fpm

# Copy WordPress files and Composer dependencies
COPY bedrock /var/www/html/

# Install PHP dependencies
RUN apt-get update && \ 
    apt-get install -y zip libzip-dev libpng-dev

# Install additional PHP modules
RUN docker-php-ext-install mysqli pdo pdo_mysql gd zip

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Install Composer
COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

# Install Stunnel
RUN mkdir -p /etc/stunnel
ADD stunnel/stunnel.conf /etc/stunnel/stunnel.conf
ADD stunnel/start_stunnel.sh /etc/stunnel/start_stunnel.sh
RUN apt-get update && \ 
    apt-get -y install stunnel && \ 
    apt-get -y install net-tools

# Uprade system components 
RUN apt-get upgrade -y

# Add the default user
RUN useradd -g root -m -u 1001 des

# CMD ["/start_stunnel.sh"]