export PGUSER=postgres
# Username and password gets changed here
psql <<- EOSQL
    CREATE DATABASE mattermost;
    CREATE USER $(</etc/secrets/username) WITH PASSWORD '$(</etc/secrets/password)';
    GRANT ALL PRIVILEGES ON DATABASE mattermost to mmuser;
EOSQL
