from fastapi import APIRouter, Request, Response
import json
from postgre_support import PostgreSupport


router = APIRouter()

postgre = PostgreSupport()
postgre.connect_db()


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

    res_data = 'You are not logined!'

    if res_login == 2:
        res_data = "You are not logined! Login or password is wrong!"
    elif res_login == 0:
        res_data = "Login is not exist! Maybe you need to register!"
    elif res_login == 1:
        res_data = 'You are logined!!'

    # print(request.headers)
    response.headers['content-type'] = 'text/html'
    print(response.headers)

    # print(res_data)
    return Response(content=res_data, media_type="text/html")

@router.post('/user/register')
async def register_user(request: Request, response: Response):
    login_body = await request.body()

    # print(f'login_body = {login_body}')0
    obj_user = json.loads(login_body)

    user_name = obj_user["name"]
    user_last = obj_user["name_last"]
    date_birth = obj_user["date_birth"]
    user_sex = obj_user["sex"]   # 0 - female, 1 - male
    user_city = obj_user["city"]
    user_interests = obj_user["interests"]
    login = obj_user["login"]
    passw = obj_user["password"]

    print(f'login = {obj_user["login"]}, password = {obj_user["password"]}')

    res_data = 'You are not registered!'
    res_login = postgre.check_login(obj_user["login"])
    if res_login == 2:
        postgre.add_user(name=user_name,
                         name_last=user_last,
                         date_birth=date_birth,
                         sex=user_sex,
                         city=user_city,
                         interests=user_interests,
                         login=login,
                         password=passw)
        res_data = 'You are registered!'
    elif res_login == 1:
        res_data = 'You are not registered! The specified login already exists!'
    else:
        res_data = 'The specified login already exists! '

    # print(request.headers)
    response.headers['content-type'] = 'text/html'
    print(response.headers)

    # print(res_data)
    return Response(content=res_data, media_type="text/html")