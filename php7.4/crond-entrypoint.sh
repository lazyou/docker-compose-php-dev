#!/bin/sh

set -e

if [[ $1 = "/usr/sbin/crond" ]];then
    echo '* * * * * /usr/local/bin/php /var/www/artisan schedule:run >> /var/log/cron.log 2>&1' > /var/spool/cron/crontabs/root
    echo '' >> /var/spool/cron/crontabs/root
fi

exec "$@"