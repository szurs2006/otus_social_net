import redis
import json


class CacheSupport:
    def __init__(self, user="default",
                 password="redispw",
                 host="localhost",
                 port="49153"
                 ):
        self.connection = None
        self.user = user
        self.password = password
        self.host = host
        self.port = port

    def __del__(self):
        if self.connection:
            self.connection.close()
            print("Соединение с Redis закрыто")

    def connect_cache(self):
        try:
            self.connection = redis.Redis(host=self.host,
                                          port=self.port,
                                          username=self.user,
                                          password=self.password,
                                          decode_responses=True)
            print("Соединение с Redis открыто")
            return True
        except Exception as error:
            print("Ошибка соединения с Redis:", error)
            return False

    def get_posts_friends_from_cache(self, params):
        cache_value = self.connection.get(params['id_user'])
        result = {}
        if cache_value is not None:
            print('Load from Cache')
            return cache_value
        # result = postgre.feed_friends_posts(params)
        # print('Load from Database')
        # self.connection.set(params['id_user'], json.dumps(result, default=str))
        #redis_client.close()
        return result

    def set_posts_friends_to_cache(self, params, obj_posts):
        # cache_value = self.connection.get(params['id_user'])
        # if cache_value is not None:
        #     print('Load from Cache')
        #     return json.loads(cache_value)
        #
        # result = postgre.feed_friends_posts(params)
        # print('Load from Database')
        self.connection.set(params['id_user'], json.dumps(obj_posts, default=str))
        # redis_client.close()
        # return result