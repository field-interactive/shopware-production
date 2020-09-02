FROM php:7.3-fpm

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

# Run apt update and install some dependancies needed for docker-php-ext
RUN apt update && apt install -y apt-utils mariadb-client pngquant unzip zip libzip-dev libpng-dev \
    libmcrypt-dev git curl libicu-dev libxml2-dev libssl-dev libcurl4 libcurl4-openssl-dev \
    ruby build-essential libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev

RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && mkdir -p /tmp/blackfire \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp/blackfire \
    && mv /tmp/blackfire/blackfire-*.so $(php -r "echo ini_get ('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini \
    && rm -rf /tmp/blackfire /tmp/blackfire-probe.tar.gz

RUN gem install capistrano

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd    

# Install PHP extensions
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install intl
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install zip
RUN docker-php-ext-install opcache

# Add composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Add a pseudo docker user with uid/gid 1000
RUN groupadd -g 1000 -o docker
RUN useradd -m -u 1000 -g 1000 -o -s /bin/bash docker

# Set default user to this user so the interactive login 
# writes/executes with the same permissions as the mounted volume
USER 1000
