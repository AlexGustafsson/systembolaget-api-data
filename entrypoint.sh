#!/usr/bin/env bash

# Docker entrypoint

cron="$1"
shift
parameters="$*"

mkdir /etc/bot/crontabs
cat <<EOF > /etc/bot/crontabs/bot
$cron /etc/bot/bot.sh $parameters > /proc/1/fd/1 2>&1
EOF

echo "crontab"
cat /etc/bot/crontabs/bot

echo "parameters"
echo "$parameters"

echo "starting supercronic"
supercronic -debug /etc/bot/crontabs/bot
