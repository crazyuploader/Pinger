#!/usr/bin/env bash

# Script to create cron for X minute(s)

if [[ -z "${CRON_MINUTES}" ]]; then
    echo "Cron minute(s) Environment Variable 'CRON_MINUTES' is not defined, using default of 10 minute(s)"
else
    echo "Setting up cron every ${CRON_MINUTES:-5} minute(s)"
fi
echo "*/${CRON_MINUTES:-5} * * * * /pinger/mtr.sh" >> /etc/crontabs/root
echo "Cron OK..."
echo "Starting Pinger..."
crond -f -d 8
