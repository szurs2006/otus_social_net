from fastapi import APIRouter, Request, Response
import json
from common import postgre
from common import cache
# from cache_support import get_posts_friends_from_cache

# from postgre_support import PostgreSupport
# from cache_support import get_posts_friends_from_cache

router = APIRouter()

# postgre = PostgreSupport()
# postgre.connect_db()


@router.get("/")
async def root(request: Request):
    print(request.headers)
    req_body = await request.body()
    print(f'req_body = {req_body}')

    return {"message": "Hello, OTUS"}


@router.post('/user/login')
async def login(request: Request, response: Response):
    login_body = await request.body()

    # print(f'login_body = {login_body}')0
    obj_login = json.loads(login_body)

    print(f'login = {obj_login["login"]}, password = {obj_login["password"]}')

    res_login = postgre.check_password(obj_login["login"], obj_login["password"])

    res_data = 'You are not logined! Login or password is wrong!'

    if res_login > 0:
        res_data = 'You are logined!!'

    # print(request.headers)
    response.headers['content-type'] = 'application/json'
    print(response.headers)

    res_obj = {
        'id_user': res_login,
        'res_text': res_data
    }
    # print(res_data)
    return Response(content=json.dumps(res_obj), media_type="application/json")


@router.post('/user/register')
async def register_user(request: Request, response: Response):
    login_body = await request.body()

    # print(f'login_body = {login_body}')0
    obj_user = json.loads(login_body)

    user_name = obj_user["name"]
    user_last = obj_user["name_last"]
    date_birth = obj_user["date_birth"]
    user_sex = obj_user["sex"]  # 0 - female, 1 - male
    user_city = obj_user["city"]
    user_interests = obj_user["interests"]
    login = obj_user["login"]
    passw = obj_user["password"]

    print(f'login = {obj_user["login"]}, password = {obj_user["password"]}')

    res_data = 'You are not registered!'
    id_user = 0
    res_login = postgre.check_login(obj_user["login"])
    if res_login == 2:
        id_user = postgre.add_user(name=user_name,
                                   name_last=user_last,
                                   date_birth=date_birth,
                                   sex=user_sex,
                                   city=user_city,
                                   interests=user_interests,
                                   login=login,
                                   password=passw)
        if id_user > 0:
            res_data = 'You are registered!'
    elif res_login == 1:
        res_data = 'You are not registered! The specified login already exists!'
    else:
        res_data = 'The specified login already exists! '
    res_obj = {
        'id_user': id_user,
        'res_text': res_data
    }

    # print(request.headers)
    response.headers['content-type'] = 'application/json'  # 'text/html'
    print(response.headers)

    # print(res_data)
    return Response(content=json.dumps(res_obj), media_type="application/json")


@router.get("/user/get/{id_user}")
def get_user_by_id(id_user: str, request: Request, response: Response):
    user_dict = postgre.get_user_data(id_user)
    res_obj = {
        'id_user': id_user,
        'res_text': "Cannot find user!"
    }
    if not user_dict:
        user_dict = res_obj

    # client_host = request.client.host

    response.headers['content-type'] = 'application/json'  # 'text/html'
    print(response.headers)

    # print(res_data)
    return Response(content=json.dumps(user_dict), media_type="application/json")


@router.get("/user/search/")
def search_user(name: str, last_name: str, request: Request, response: Response):
    params = request.query_params

    users_result = postgre.search_users(params)

    # user_dict = postgre.get_user_data(id_user)
    # res_obj = {
    #     'id_user': id_user,
    #     'res_text': "Cannot find user!"
    # }
    # if not user_dict:
    #     user_dict = res_obj

    # client_host = request.client.host

    response.headers['content-type'] = 'application/json'  # 'text/html'
    print(response.headers)

    # print(res_data)
    return Response(content=json.dumps(users_result, default=str), media_type="application/json")


@router.post('/friend/add')
async def friend_add(request: Request, response: Response):
    body = await request.body()

    # print(f'login_body = {login_body}')0
    obj_tofriend = json.loads(body)

    id_user = obj_tofriend["id_user"]
    id_friend = obj_tofriend["id_friend"]

    print(f'user_id = {obj_tofriend["id_user"]}, friend_id = {obj_tofriend["id_friend"]}')

    if postgre.add_friend(id_user=id_user,
                          id_friend=id_friend):
        res_data = 'You added new friend!'
        # invalidate_cache(id_user=id_user)
    else:
        res_data = 'You cannot add new friend! May be you have this friend already!'

    response.headers['content-type'] = 'application/json'  # 'text/html'
    # print(response.headers)

    # print(res_data)
    return Response(res_data)


@router.get("/post/feed/")
def post_feed(id_user: str, offset: str, limit: str, request: Request, response: Response):
    params = request.query_params
    post_result = ''
    cache_value = cache.get_posts_friends_from_cache(params)
    if cache_value is not None:
        print('Load from Cache')
        post_result = json.loads(cache_value)
    else:
        post_result = postgre.feed_friends_posts(params)
        cache.set_posts_friends_to_cache(params, post_result)

    # post_result = cache.get_posts_friends_from_cache(params)
    # posts_result = postgre.feed_friends_posts(params)

    post_friends = post_result[int(params['offset']):]

    response.headers['content-type'] = 'application/json'  # 'text/html'
    print(response.headers)

    # print(res_data)
    return Response(content=json.dumps(post_friends, default=str), media_type="application/json")