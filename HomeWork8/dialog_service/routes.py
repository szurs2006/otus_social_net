from fastapi import APIRouter, Request, Response, WebSocket, WebSocketDisconnect
import json
from common_service import rediss

from typing import Optional
from pydantic import BaseModel

router = APIRouter()


@router.get("/")
async def root(request: Request):
    print(request.headers)
    req_body = await request.body()
    print(f'req_body = {req_body}')

    return {"message": "Hello, Dialog Service"}


class ItemDialog(BaseModel):
    from_user: str
    to_user: str
    dialog_text: str

    # description: Optional[str] = None
    # price: float
    # tax: Optional[float] = None


@router.post('/dialog/send')
async def send_dialog(item: ItemDialog):

    json_string = item.model_dump_json()
    obj_post = json.loads(json_string)

    from_user = obj_post["from_user"]
    to_user = obj_post["to_user"]
    dialog_text = obj_post["dialog_text"]

    print(f'from_user = {from_user}, to_user = {to_user}, dialog_text = {dialog_text}')

    if rediss.add_dialog_text(from_user=from_user, to_user=to_user, dialog_text=dialog_text):
        res_data = f'You added new dialog for user with id = {to_user}!'
    else:
        res_data = 'You cannot add new dialog!!'

    response = Response(res_data)
    response.headers['content-type'] = 'application/json'  # 'text/html'
    return response
    # return Response(res_data)


@router.get("/dialog/list/{id_user}")
def get_dialogs_by_id_user(id_user: str, request: Request, response: Response):

    user_dict = rediss.get_dialogs_by_id_user(id_user)
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
