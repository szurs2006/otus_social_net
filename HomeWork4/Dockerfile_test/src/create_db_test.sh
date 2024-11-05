echo "IP"
hostname -i

echo "Sleeping for 5 seconds…"
sleep 5

echo "Start script"
psql postgresql://serg:aiWgIDHKPdHr@postgres_db:5432/OTUS  -a -f "/src/test_db.sql"