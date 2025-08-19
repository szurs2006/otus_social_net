import json
import pika
import psycopg2

COUNTERS_DSN = "postgresql://postgres:pass@localhost:54322/postgres"
RABBITMQ_URL = "amqp://guest:guest@localhost/"  # "amqp://guest:guest@rabbitmq:5672/%2F"
EXCHANGE = "messaging.events"
QUEUE = "unread_counters"

def begin():
    conn = psycopg2.connect(COUNTERS_DSN)
    cur = conn.cursor()
    return conn, cur

def apply_event(event_id: str, user_id: int, delta: int):
    conn, cur = begin()
    try:
        # 1) идемпотентность
        cur.execute("""
            insert into processed_events (event_id)
            values (%s)
            on conflict do nothing
        """, (event_id,))
        if cur.rowcount == 0:
            conn.rollback()
            return

        # 2) изменение счётчика
        cur.execute("""
            insert into unread_counters (user_id, unread_count)
            values (%s, %s)
            on conflict (user_id) do update
            set unread_count = unread_counters.unread_count + EXCLUDED.unread_count
        """, (user_id, delta))

        cur.execute("""
            update unread_counters
            set unread_count = greatest(unread_count, 0)
            where user_id = %s
        """, (user_id,))

        conn.commit()
    except Exception:
        conn.rollback()
        raise
    finally:
        cur.close()
        conn.close()

def on_message(ch, method, properties, body):
    msg = json.loads(body.decode("utf-8"))
    event_id = msg["event_id"]
    payload = msg["payload"]
    user_id = int(payload["id_to_user"])
    delta = int(payload["delta"])

    apply_event(event_id, user_id, delta)
    ch.basic_ack(delivery_tag=method.delivery_tag)

def run_consumer():
    params = pika.URLParameters(RABBITMQ_URL)
    connection = pika.BlockingConnection(params)
    channel = connection.channel()

    channel.exchange_declare(exchange=EXCHANGE, exchange_type="topic", durable=True)
    channel.queue_declare(queue=QUEUE, durable=True)

    channel.queue_bind(queue=QUEUE, exchange=EXCHANGE, routing_key="message_created.*")
    channel.queue_bind(queue=QUEUE, exchange=EXCHANGE, routing_key="message_read.*")

    channel.basic_qos(prefetch_count=200)
    channel.basic_consume(queue=QUEUE, on_message_callback=on_message)

    channel.start_consuming()

if __name__ == "__main__":
    run_consumer()
