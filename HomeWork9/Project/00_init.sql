CREATE USER rep1 WITH REPLICATION ENCRYPTED PASSWORD 'passrep1';
SELECT pg_create_physical_replication_slot('replication_slot1');

CREATE USER rep2 WITH REPLICATION ENCRYPTED PASSWORD 'passrep2';
SELECT pg_create_physical_replication_slot('replication_slot2');
