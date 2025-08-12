from flask import Flask
import os
import psycopg2

app = Flask(__name__)

@app.route("/")
def index():
    try:
        conn = psycopg2.connect(
            host="haproxy",
            port=5433,
            dbname="postgres",
            user="postgres",
            password="pass"
        )
        cur = conn.cursor()
        cur.execute("SELECT NOW();")
        result = cur.fetchone()
        time_now = result[0]
        cur.execute("SELECT inet_server_addr();") # inet_server_addr()  inet_server_port()
        result = cur.fetchone()
        addr_now = result[0]
        cur.close()
        conn.close()
        return f"Hello from {os.getenv('HOSTNAME')}! DB address: {addr_now}, DB Time: {time_now}"
    except Exception as e:
        return f"DB connection error: {e}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
