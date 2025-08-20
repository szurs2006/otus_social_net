import json
import psycopg2
from datetime import datetime, timezone


class TransactionalOutbox:
    def __init__(self):
        # self.pg = pg
        self.table = "outbox"

    def add_event(self, cur, event_type: str, aggregate_id: str, payload: dict):
        cur.execute(
            f"""
            insert into {self.table} (event_type, aggregate_id, payload)
            values (%s, %s, %s::jsonb)
            returning id
            """,
            (event_type, aggregate_id, json.dumps(payload))
        )
        (event_id,) = cur.fetchone()
        return event_id

    def fetch_batch_for_relay(self, cur, batch_size=100):
        cur.execute(
            f"""
            select id, event_type, aggregate_id, payload
            from {self.table}
            where sent_at is null
            order by created_at
            for update skip locked
            limit %s
            """,
            (batch_size,)
        )
        return cur.fetchall()

    def mark_sent(self, cur, event_id):
        cur.execute(
            f"update {self.table} set sent_at = %s where id = %s",
            (datetime.now(timezone.utc), event_id)
        )
