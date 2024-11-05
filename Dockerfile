FROM python:3.11.10-slim
ENV PYTHONUNBUFFERED 1
COPY ./requirements.txt .
RUN pip install --upgrade pip \ 
    && pip install --no-cache -r requirements.txt
WORKDIR /app
COPY . /app
EXPOSE 8070
CMD ["python","main.py" ]
