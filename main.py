import uvicorn
from fastapi import FastAPI
from handlers import router



def get_app() -> FastAPI:
    application = FastAPI(title='Social Network for OTUS',
                          description='Social Network for Course Highload Architect from OTUS running on FastAPI + uvicorn',
                          version='0.0.1')
    application.include_router(router)
    return application


app = get_app()

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8070)
