#!/bin/sh

set -e

role=${CONTAINER_ROLE:-app}

if [ "$role" = "scheduler" ]; then
    while [ true ]
    do
    #   /usr/local/bin/php /var/www/html/artisan schedule:run --no-interaction &
      sleep 60
    done
else
	exec php-fpm
fi
