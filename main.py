import uvicorn
from fastapi import FastAPI, Request, Response
from handlers import router
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST
import time

REQUEST_COUNT = Counter(
    "http_requests_total",
    "Total HTTP requests",
    ["method", "endpoint", "status"],
)

REQUEST_LATENCY = Histogram(
    "http_request_duration_seconds",
    "Request duration (s)",
    ["method", "endpoint"],
    buckets=(0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1, 2.5, 5, 10),
)

REQUEST_ERRORS = Counter(
    "http_request_errors_total",
    "Total HTTP error responses",
    ["method", "endpoint", "status"],
)


def get_app() -> FastAPI:
    application = FastAPI(title='Social Network for OTUS',
                          description='Social Network for Course Highload Architect from OTUS running on FastAPI + uvicorn',
                          version='0.0.1')
    application.include_router(router)
    return application


app = get_app()


@app.middleware("http")
async def prometheus_middleware(request: Request, call_next):
    start_time = time.time()
    try:
        response = await call_next(request)
        status_code = response.status_code
    except Exception:
        status_code = 500
        raise
    finally:
        duration = time.time() - start_time
        method = request.method
        endpoint = request.url.path

        REQUEST_COUNT.labels(method, endpoint, status_code).inc()
        REQUEST_LATENCY.labels(method, endpoint).observe(duration)
        if int(status_code) >= 400:
            REQUEST_ERRORS.labels(method, endpoint, status_code).inc()

    return response


@app.get("/metrics")
def metrics():
    return Response(generate_latest(), media_type=CONTENT_TYPE_LATEST)


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8070)
