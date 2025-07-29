import asyncio
from fastapi import APIRouter, Request, Response, WebSocket, WebSocketDisconnect
import json
from common import postgre
from common import postgre_repl1
from common import cache
from common import invalidate_cache
from rabbitmq_support import RabbitMQService
from typing import Dict
import requests

# --- Константы ---
RABBITMQ_URL = "amqp://guest:guest@localhost/"
QUEUE_NAME = "my_queue"

rabbitmq_service = RabbitMQService(RABBITMQ_URL, QUEUE_NAME)

router = APIRouter()


@router.on_event("startup")
async def startup():
    await rabbitmq_service.connect()
    asyncio.create_task(rabbitmq_service.start_consumer())


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

    res_login = postgre_repl1.check_password(obj_login["login"], obj_login["password"])

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
    res_login = postgre_repl1.check_login(obj_user["login"])
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
    user_dict = postgre_repl1.get_user_data(id_user)
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

    users_result = postgre_repl1.search_users(params)

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
        invalidate_cache(obj_tofriend)
    else:
        res_data = 'You cannot add new friend! May be you have this friend already!'

    response.headers['content-type'] = 'application/json'  # 'text/html'
    # print(response.headers)

    # print(res_data)
    return Response(res_data)


@router.post('/post/create')
async def create_post(request: Request, response: Response):
    body = await request.body()

    obj_post = json.loads(body)

    id_user = obj_post["id_user"]
    new_post = obj_post["new_post"]

    print(f'id_user = {obj_post["id_user"]}, new_post = {obj_post["new_post"]}')

    res_data = 'You cannot add new post!!'

    if postgre.add_post(id_user=id_user, new_post=new_post):
        res_data = f'You added new post for user with id = {id_user}!'
        await rabbitmq_service.send(obj_post)

    # if postgre.add_post(id_user=id_user,
    #                     new_post=new_post):
    #     users_invalidated = postgre.get_users_by_friend(id_user)
    #     for user_inv in users_invalidated:
    #         users_obj = {'id_user': user_inv}
    #         invalidate_cache(users_obj)
    #         # userrkey = get_routekey_for user(user_inv)
    #         # send_mes_to_queue(userrkey)
    # else:
    #     res_data = 'You cannot add new post!!'

    response.headers['content-type'] = 'application/json'  # 'text/html'

    return Response(res_data)


@router.get("/post/feed/")
def post_feed(id_user: str, offset: str, limit: str, request: Request, response: Response):
    params = request.query_params
    post_result = ''
    cache_value = cache.get_posts_friends_from_cache(params)
    if cache_value is not None:
        print(f'Load from Cache - {cache_value}')
        try:
            post_result = json.loads(cache_value)
        except Exception as error:
            print(f'No data')
            post_result = {}
    else:
        post_result = invalidate_cache(params)
        # post_result = postgre.feed_friends_posts(params)
        # cache.set_posts_friends_to_cache(params, post_result)

    post_friends = post_result[int(params['offset']):]

    response.headers['content-type'] = 'application/json'  # 'text/html'
    print(response.headers)

    # print(res_data)
    return Response(content=json.dumps(post_friends, default=str), media_type="application/json")


@router.post('/dialog/send')
async def send_dialog(request: Request, response: Response):
    body = await request.body()

    obj_post = json.loads(body)

    from_user = obj_post["from_user"]
    to_user = obj_post["to_user"]
    dialog_text = obj_post["dialog_text"]

    print(f'from_user = {from_user}, to_user = {to_user}, dialog_text = {dialog_text}')

    if cache.add_dialog_text(from_user=from_user, to_user=to_user, dialog_text=dialog_text):
        res_data = f'You added new dialog for user with id = {to_user}!'
    else:
        res_data = 'You cannot add new dialog!!'

    response.headers['content-type'] = 'application/json'  # 'text/html'

    return Response(res_data)


@router.get("/dialog/list/{id_user}")
def get_dialogs_by_id_user(id_user: str, request: Request, response: Response):
    user_dict = cache.get_dialogs_by_user_id(id_user)
    res_obj = {
        'id_user': id_user,
        'res_text': "No data for user!"
    }
    if not user_dict:
        user_dict = res_obj

    # client_host = request.client.host

    response.headers['content-type'] = 'application/json'  # 'text/html'
    print(response.headers)

    # print(res_data)
    return Response(content=json.dumps(user_dict), media_type="application/json")


@router.post('/v2/dialog/send')
async def send_dialog(request: Request, response: Response):

    response.headers['content-type'] = 'application/json'

    body = await request.body()

    obj_post = json.loads(body)

    from_user = obj_post["from_user"]
    to_user = obj_post["to_user"]
    dialog_text = obj_post["dialog_text"]

    print(f'from_user = {from_user}, to_user = {to_user}, dialog_text = {dialog_text}')

    try:
        response = requests.post(url='http://localhost:8071/dialog/send', json=obj_post)

        if response.status_code == 200:
            print("POST request successful!")
            print("Response JSON:", response.text)

        else:
            print(f"POST request failed with status code: {response.status_code}")
            print("Response text:", response.text)
        res_data = response.text
    except requests.exceptions.RequestException as e:
        print(f"Ошибка при отправке запроса к Dialog Service: {e}")
        res_data = 'You cannot add new dialog!!'

    return Response(res_data)


@router.get("/v2/dialog/list/{id_user}")
def get_dialogs_by_id_user(id_user: str, request: Request, response: Response):
    res_obj = {
        'id_user': id_user,
        'res_text': "No data for user!"
    }
    try:
        urls = 'http://localhost:8071/dialog/list/'+id_user
        response = requests.get(url=urls)

        if response.status_code == 200:
            print("POST request successful!")
            print("Response JSON:", response.text)
        else:
            print(f"POST request failed with status code: {response.status_code}")
            print("Response text:", response.text)
        res_obj = json.loads(response.text)
    except requests.exceptions.RequestException as e:
        print(f"Ошибка при отправке запроса к Dialog Service: {e}")
        res_obj = {'Error': 'You cannot get any dialogs!!'}

    return Response(content=json.dumps(res_obj), media_type="application/json")


clients: Dict[WebSocket, str] = {}


@router.websocket("/ws/{user_id}")
async def websocket_endpoint(websocket: WebSocket, user_id: int):
    await websocket.accept()

    clients[websocket] = user_id

    user_dict = postgre_repl1.get_user_data(user_id)
    if user_dict is not None and len(user_dict) != 0:
        await websocket.send_text(f"Здравствуйте, {user_dict['name']} {user_dict['name_last']}")
        clients[websocket] = user_id
        print(f"{user_id} подключился.")

        await websocket.send_text(f"Cейчас подгоню ленту постов друзей:")
        feed_list = postgre_repl1.get_user_feed(user_id, 0)
        if feed_list is not None and len(feed_list) != 0:
            for feed in feed_list:
                await websocket.send_text(feed[1])
        try:
            while True:
                await asyncio.sleep(10)
                feed_list = postgre_repl1.get_user_feed(user_id, 10)
                if feed_list is not None and len(feed_list) != 0:
                    for feed in feed_list:
                        await websocket.send_text(feed[1])
        except WebSocketDisconnect:
            print(f"{user_id} отключился.")
            del clients[websocket]

