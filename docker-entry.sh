#!/bin/bash
config=/mattermost/config/config.json
echo -ne "Configure database connection..."
if [ ! -f $config ]
then
    cp /config.template.json $config
    PGUSER=$(</etc/pgsecrets/username)
    PGPASS=$(</etc/pgsecrets/password)

    sed -i -e "s/POSTGRES_USER/$PGUSER/g" $config
    sed -i -e "s/POSTGRES_PASSWORD/$PGPASS/g" $config

    echo OK
else
    echo SKIP
fi

echo "Wait until database is ready..."
until nc -z localhost 5432
do
    sleep 1
done

# Wait to avoid "panic: Failed to open sql connection pq: the database system is starting up"
sleep 5

echo "Starting platform"
cd /mattermost/bin
./platform
