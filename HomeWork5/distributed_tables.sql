SELECT create_reference_table('users')

SELECT create_distributed_table('dialogs', 'dist_key');

SELECT master_get_active_worker_nodes();

SELECT nodename, count(*) FROM citus_shards GROUP BY nodename;

SELECT shard_count FROM citus_tables WHERE table_name::text = 'dialogs';

alter system set wal_level = logical; 
SELECT run_command_on_workers('alter system set wal_level = logical');
-- docker exec -it citus-worker-1 psql -U postgres
-- show wal-level;

SELECT * from master_add_node('citus-worker-7', 12345);

SELECT rebalance_table_shards('dialogs');
SELECT citus_rebalance_start();
SELECT * FROM citus_rebalance_status();


-- docker-compose -p citus up --scale worker=7 -d

CREATE UNIQUE INDEX key_created_unique
  ON dialogs (created_at, dist_key);
ALTER TABLE dialogs REPLICA IDENTITY
  USING INDEX key_created_unique;  




