FROM php:7.4-fpm-alpine

# Install awesome extentions
RUN apk add --no-cache freetype \
    bash mysql-client curl \
    icu-dev \
    libzip-dev zip zlib-dev \
    redis nodejs npm build-base gcc autoconf \
    libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) \
    opcache intl pdo_mysql zip exif gd && \
    apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

# Install redis native ext
RUN pecl install -o -f redis igbinary \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis igbinary

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add boosted php.ini config
ADD php.ini /usr/local/etc/php/php.ini

# Attach volume for your application
VOLUME /app

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
