FROM php:8.2-fpm

# Installing dependencies for the PHP modules
RUN apt-get update && \
    apt-get install -y zip libzip-dev libpng-dev

# Installing additional PHP modules
RUN docker-php-ext-install mysqli pdo pdo_mysql gd zip

# Copy WordPress files and Composer dependencies
COPY bedrock /srv/www/localhost/

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Install Redis
# RUN apt-get install -y lsb-release curl gpg

# RUN curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg \
# 	&& echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main"  tee /etc/apt/sources.list.d/redis.list \
# 	&& apt-get update \
# 	&& apt-get install -y redis

# Latest release
COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

# RUN wp core install --allow-root --path=/srv/www/localhost/ --url=http://localhost:1024 --title="DES WordPress" --admin_user=des --admin_password=7ujm,ki8 --admin_email=des@gov.bc.ca

RUN useradd -g root -m -u 1001 des