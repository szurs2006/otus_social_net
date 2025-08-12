#!/bin/bash
set -e

# Если данных нет — делаем basebackup с мастера
if [ -z "$(ls -A $PGDATA)" ]; then
    echo "Running pg_basebackup from $MASTER_HOST..."
    rm -rf $PGDATA/*
    PGPASSWORD=$REPL_PASSWORD pg_basebackup \
        -h $MASTER_HOST \
        -U $REPL_USER \
        -D $PGDATA \
        -Fp -Xs -P -R \
        -d "postgres"
    chmod 0700 $PGDATA
fi

# Запускаем стандартный entrypoint Postgres
exec docker-entrypoint.sh postgres

