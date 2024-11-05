from cache_support import CacheSupport
from postgre_support import PostgreSupport
import time

postgre = PostgreSupport()
cache = CacheSupport()

i = 0
while not postgre.connect_db():
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
