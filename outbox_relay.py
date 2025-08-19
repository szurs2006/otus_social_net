import json
import time
import pika
from outbox import TransactionalOutbox
from common import postgre
from contextlib import contextmanager
import psycopg2
import psycopg2.extras

# MESSAGES_DSN = "postgresql://postgres:pass@localhost:5432/postgres"
RABBITMQ_URL = "amqp://guest:guest@localhost/"  # amqp://guest:guest@localhost/   amqp://guest:guest@rabbitmq:5672/%2F
EXCHANGE = "messaging.events"


# class Postgres:
#     def __init__(self, dsn: str):
#         self.dsn = dsn
#
#     @contextmanager
#     def conn(self):
#         conn = psycopg2.connect(self.dsn)
#         try:
#             yield conn
#         finally:
#             conn.close()
#
#     @contextmanager
#     def tx(self):
#         with self.conn() as c:
#             try:
#                 yield c
#                 c.commit()
#             except Exception:
#                 c.rollback()
#                 raise
#
#
# pg = Postgres(MESSAGES_DSN)
outbox = TransactionalOutbox()


def setup_rabbit():
    params = pika.URLParameters(RABBITMQ_URL)
    conn = pika.BlockingConnection(params)
    ch = conn.channel()
    ch.exchange_declare(exchange=EXCHANGE, exchange_type="topic", durable=True)
    return conn, ch


def relay_loop():
    conn_rabbit, ch = setup_rabbit()
    try:
        while True:
            sent_any = False
            conn = postgre.connection
            cur = postgre.connection.cursor()
            try:
                rows = outbox.fetch_batch_for_relay(cur, batch_size=200)
                for (event_id, event_type, aggregate_id, payload) in rows:
                    body = json.dumps({
                        "event_id": str(event_id),
                        "type": event_type,
                        "aggregate_id": aggregate_id,
                        "payload": payload
                    }).encode("utf-8")

                    routing_key = f"{event_type}.{aggregate_id}"

                    ch.basic_publish(
                        exchange=EXCHANGE,
                        routing_key=routing_key,
                        body=body,
                        properties=pika.BasicProperties(
                            content_type="application/json",
                            delivery_mode=2
                        )
                    )

                    outbox.mark_sent(cur, event_id)
                    sent_any = True

                conn.commit()
            except Exception:
                conn.rollback()
                raise
            finally:
                cur.close()
                # conn.close()

            if not sent_any:
                time.sleep(0.25)
    finally:
        try:
            conn_rabbit.close()
        except Exception:
            pass


if __name__ == "__main__":
    relay_loop()
