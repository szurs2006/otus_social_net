FROM python:3.11.10-slim
ENV PYTHONUNBUFFERED 1
COPY ./requirements.txt .
#RUN \
# apk add --no-cache postgresql-libs && \
# apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
# python3 -m pip install -r requirements.txt --no-cache-dir && \
# apk --purge del .build-deps \
RUN pip install --upgrade pip \
    && pip install --no-cache -r requirements.txt
WORKDIR /app
COPY . /app
EXPOSE 8070
CMD ["python","main.py" ]
