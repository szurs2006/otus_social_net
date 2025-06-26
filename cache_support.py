import redis
import json


class CacheSupport:
    # def __init__(self, user="default",
    #              password="redispw",
    #              host="redis_db",
    #              port="6379"
    #              ):
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
        print(f'Redis host = {self.host}, port = {self.port}')

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
                                          decode_responses=False)
            self.connection.flushall()
            print("Соединение с Redis открыто")
            return True
        except Exception as error:
            print("Ошибка соединения с Redis:", error)
            return False

    def get_posts_friends_from_cache(self, params):
        cache_value = None
        if self.connection.exists(params['id_user']):
            cache_value = self.connection.get(params['id_user'])
            # if cache_value is not None:
            if cache_value == b'[]':
                cache_value = None
            else:
                print('Load from Cache')
                return cache_value
        return cache_value

    def set_posts_friends_to_cache(self, params: dict, obj_posts: object):
        self.connection.set(params['id_user'], json.dumps(obj_posts, default=str))
