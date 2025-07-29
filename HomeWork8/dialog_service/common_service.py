from redis_support import RedisSupport
import time
import configparser


config = configparser.ConfigParser()
config.read("config_service.cfg")

rediss = RedisSupport(user=config["DB_REDIS"]["USER"],
                     password=config["DB_REDIS"]["PASSWORD"],
                     host=config["DB_REDIS"]["IP_ADDRESS"],
                     port=config["DB_REDIS"]["PORT"])


i = 0
while not rediss.connect_redis():
    time.sleep(5)
    i += 1
    if i > 10:
        break