import redis
import json
import datetime

class CacheSupport:
    def __init__(self, **connp):
        self.user = connp['user']
        self.password = connp['password']
        self.host = connp['host']
        self.port = connp['port']
    # def __init__(self, user="default",
    #                  password="redispw",
    #                  host="172.18.0.3",#"localhost",
    #                  port="49153"
    #                  ):
    #     self.connection = None
    #     self.user = user
    #     self.password = password
    #     self.host = host
    #     self.port = port
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
            self.register_lua_func()
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

    def register_lua_func(self):
        lua_code = """
        #!lua name=hashmod

        redis.register_function('store_string_with_hash', function(keys, args)
            local num1 = tonumber(args[1])
            local num2 = tonumber(args[2])
            local input_str = args[3]
            
            redis.log(redis.LOG_NOTICE, "ARGS: " .. tostring(num1) .. ", " .. tostring(num2) .. ", " .. input_str)
            if not num1 or not num2 or not input_str then
                error("Неверные аргументы")
            end
            local sorted_nums = {}
            if num1 < num2 then
                sorted_nums = {num1, num2}
            else
                sorted_nums = {num2, num1}
            end
            local key_base = tostring(sorted_nums[1]) .. ":" .. tostring(sorted_nums[2])
            local key_hash = redis.sha1hex(key_base)
            
            local now = redis.call('TIME')
            local seconds = tonumber(now[1])
            local microseconds = tonumber(now[2])
            local timestamp = seconds + microseconds / 1000000
            
            redis.call('ZADD', key_hash, timestamp, input_str)
            -- redis.call("SET", key_hash, input_str)
            return key_hash
        end)

        redis.register_function('get_string_by_hash', function(keys, args)
            local num1 = tonumber(args[1])
            local num2 = tonumber(args[2])
            if not num1 or not num2 then
                error("Неверные аргументы")
            end
            local sorted_nums = {}
            if num1 < num2 then
                sorted_nums = {num1, num2}
            else
                sorted_nums = {num2, num1}
            end
            local key_base = tostring(sorted_nums[1]) .. ":" .. tostring(sorted_nums[2])
            local key_hash = redis.sha1hex(key_base)
            
            ------------------------
            local now = redis.call('TIME')
            local seconds = tonumber(now[1])
            local microseconds = tonumber(now[2])
            local timestamp = seconds + microseconds / 1000000
            
            local window = 30*24*3600 -- 1 месяц 
            
            local start_ts = timestamp - window
            ------------------------
            
            local value = redis.call('ZRANGEBYSCORE', key_hash, start_ts, timestamp, 'WITHSCORES')
            -- local value = redis.call("GET", key_hash)
            return value
        end)
        """
        # try:
        #     self.connection.execute_command('FUNCTION', 'DELETE', 'hashmod')
        # except redis.exceptions.ResponseError:
        #     pass
        try:
            # result = self.connection.execute_command('FUNCTION', 'LOAD', 'LUA', lua_code)
            result = self.connection.register_script(lua_code)
            print(f"Загружено на ноду {self.host}:{self.port}: {result}")
        except(Exception, redis.RedisError) as error:
            print(f"Не загружено на ноду {self.host}:{self.port} - {error} !!")
            # print(f"Не загружено на ноду {self.host}:{self.port} - {redis.exceptions.ResponseError} !!")

    def add_dialog_text(self, **dialog_data):
        if self.connection is not None:
            id_from_user = dialog_data['from_user']
            id_to_user = dialog_data['to_user']
            dialog_text = dialog_data['dialog_text']

            key_hash = self.connection.fcall('store_string_with_hash', 0, id_from_user, id_to_user, dialog_text)
            self.connection.zadd(id_from_user, {key_hash:  datetime.datetime.now().timestamp()})
            self.connection.zadd(id_to_user, {key_hash:  datetime.datetime.now().timestamp()})
            print("Сохранили под ключом:", key_hash)

    def get_dialog_users(self, **dialog_data):
        if self.connection is not None:
            id_from_user = dialog_data['from_user']
            id_to_user = dialog_data['to_user']

            stored_value = self.connection.fcall('get_string_by_hash', 0, id_from_user, id_to_user)
            print("Получили из Redis:", stored_value)

    def get_dialogs_by_user_id(self, id_user):
        if self.connection is not None:
            id_from_user = dialog_data['from_user']
            id_to_user = dialog_data['to_user']

            stored_value = self.connection.fcall('get_string_by_hash', 0, id_from_user, id_to_user)
            print("Получили из Redis:", stored_value)






