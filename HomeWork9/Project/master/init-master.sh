#!/bin/bash
set -e

# Создаём пользователя для репликации
psql -U "$POSTGRES_USER" -d postgres <<-EOSQL
    CREATE ROLE $REPL_USER REPLICATION LOGIN PASSWORD '$REPL_PASSWORD';
EOSQL

