#!/bin/bash
config=/mattermost/config/config.json
echo -ne "Configure database connection..."
if [ ! -f $config ]
then
    cp /config.template.json $config
    sed -Ei "s/DB_PORT/$MATTERMOST_DB_SERVICE_PORT/" $config
    echo OK
else
    echo SKIP
fi

echo "Wait until database is ready..."
until nc -z mattermost-db $MATTERMOST_DB_SERVICE_PORT
do
    sleep 1
done

# Wait to avoid "panic: Failed to open sql connection pq: the database system is starting up"
sleep 1

echo "Starting platform"
cd /mattermost/bin
./platform
