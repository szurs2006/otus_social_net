from cache_support import CacheSupport
from postgre_support import PostgreSupport
import time
import configparser

config = configparser.ConfigParser()
config.read("config.cfg")

postgre = PostgreSupport(user=config["DB_MASTER"]["USERNAME"],
                         password=config["DB_MASTER"]["PASSWORD"],
                         host=config["DB_MASTER"]["IP_ADDRESS"],
                         port=config["DB_MASTER"]["PORT"],
                         database=config["DB_MASTER"]["DATABASE_NAME"])

postgre_repl1 = PostgreSupport(user=config["DB_REPLICA_1"]["USERNAME"],
                               password=config["DB_REPLICA_1"]["PASSWORD"],
                               host=config["DB_REPLICA_1"]["IP_ADDRESS"],
                               port=config["DB_REPLICA_1"]["PORT"],
                               database=config["DB_REPLICA_1"]["DATABASE_NAME"])

cache = CacheSupport()

i = 0
while not postgre.connect_db():
    time.sleep(5)
    i += 1
    if i > 10:
        break

i = 0
while not postgre_repl1.connect_db():
    time.sleep(5)
    i += 1
    if i > 10:
        break

i = 0
while not cache.connect_cache():
    time.sleep(5)
    i += 1
    if i > 10:
        break
