from cache_support import CacheSupport
from postgre_support import PostgreSupport

cache = CacheSupport()
cache.connect_cache()

postgre = PostgreSupport()
postgre.connect_db()