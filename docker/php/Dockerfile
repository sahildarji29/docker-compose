FROM php:8.1.0-fpm-alpine

COPY start.sh /usr/local/bin/start

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.7.1.1-1_amd64.apk \
    && curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_17.7.1.1-1_amd64.apk

RUN apk add --update --no-cache \
	--allow-untrusted \
        curl \
        curl-dev \
        gmp-dev \
        zlib-dev \
        libpng-dev \
        jpeg-dev \
        freetype-dev \
	libjpeg-turbo-dev \
	icu-dev \
	oniguruma-dev \
	libxml2-dev \
	libzip-dev \
	pcre-dev ${PHPIZE_DEPS} \
	autoconf \
	make --verbose \
	g++ \
	msodbcsql17_17.7.1.1-1_amd64.apk \
	mssql-tools_17.7.1.1-1_amd64.apk \
	unixodbc-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd curl gmp intl mbstring pdo_mysql bcmath xml zip
#RUN pecl install sqlsrv-5.9.0 --verbose
#RUN pecl install pdo_sqlsrv-5.9.0
#RUN docker-php-ext-enable pdo_sqlsrv

RUN echo "sys_temp_dir = \"/tmp\"" >> /usr/local/etc/php/conf.d/dynamic.ini
RUN echo "memory_limit = 1G" >> /usr/local/etc/php/conf.d/dynamic.ini
RUN apk add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data && chmod +x /usr/local/bin/start

CMD ["/usr/local/bin/start"]
