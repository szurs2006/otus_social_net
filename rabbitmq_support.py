import asyncio
import aio_pika
import json
from common import postgre
from common import invalidate_cache


class RabbitMQService:
    def __init__(self, url: str, queue_name: str):
        self.url = url
        self.queue_name = queue_name
        self.connection: aio_pika.RobustConnection | None = None
        self.channel: aio_pika.abc.AbstractChannel | None = None
        self.queue: aio_pika.abc.AbstractQueue | None = None

    async def connect(self):
        self.connection = await aio_pika.connect_robust(self.url)
        self.channel = await self.connection.channel()
        self.queue = await self.channel.declare_queue(self.queue_name, durable=True)
        print("[✓] RabbitMQ connected")

    async def send(self, message: dict):
        body = json.dumps(message).encode()
        await self.channel.default_exchange.publish(
            aio_pika.Message(body=body),
            routing_key=self.queue_name
        )

    async def start_consumer(self):
        async def handle_message(message: aio_pika.IncomingMessage):
            async with message.process():
                print(" [x] Received %r" % (message,))
                obj_post = json.loads(message.body)
                id_user = obj_post["id_user"]
                new_post = obj_post["new_post"]

                followers = postgre.get_users_by_friend(id_user)
                if len(followers) > 0:
                    postgre.refresh_feed_posts()
                    for user_inv in followers:
                        users_obj = {'id_user': user_inv}
                        invalidate_cache(users_obj)
        await self.queue.consume(handle_message)
        print("[*] Consumer started")


# class RabbitMQSupport:
#     async def __init__(self):
#
#         self.connection = await aio_pika.connect_robust(host='localhost')
#         self.channel = await self.connection.channel()
#
#         queue = await self.channel.declare_queue('queue_posts', durable=True)
#
#         asyncio.create_task(queue.consume(rabbit_posts_callback))
#
#         print(f'RabbitMQ initialized!')
#
#     def __del__(self):
#         if self.connection:
#             self.connection.close()
#             print("Соединение с RabbitMQ закрыто")
#
#     async def publish_message(self, message):
#         try:
#             await self.channel.default_exchange.publish(
#                 aio_pika.Message(body=message),
#                 routing_key='queue_posts'
#             )
#         except Exception as error:
#             print("Ошибка соединения с RabbitMQ:", error)
#             return False
#
#     # def bind_queue(self, queue_name, route_key):
#     #     self.channel.queue_declare(queue=queue_name)
#     #     self.channel.queue_bind(exchange=self.name_ex, queue=queue_name, routing_key=route_key)
