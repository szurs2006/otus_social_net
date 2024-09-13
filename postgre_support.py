import psycopg2
import hashlib


class PostgreSupport:
    def __init__(self, user="serg",
                 password="aiWgIDHKPdHr",
                 host="localhost",
                 port="5432",
                 database="OTUS",
                 ):
        self.connection = None
        self.user = user
        self.password = password
        self.host = host
        self.port = port
        self.database = database

    def __del__(self):
        if self.connection:
            self.connection.close()
            print("Соединение с PostgreSQL закрыто")

    def connect_db(self):
        try:
            self.connection = psycopg2.connect(user=self.user,
                                               password=self.password,
                                               host=self.host,
                                               port=self.port,
                                               dbname=self.database
                                               )
            print("Соединение с PostgreSQL открыто")
            return True
        except(Exception, psycopg2.Error) as error:
            print("Ошибка соединения с PostgreSQL:", error)
            return False

    def check_login(self, login):
        # return 2
        if self.connection is not None:
            cursor = self.connection.cursor()
            select_query = "SELECT login FROM logins WHERE login = %s"
            cond_for_select = (login,)
            try:
                cursor.execute(select_query, cond_for_select)
                result = cursor.fetchall()[0]
                print(f'result = {result[0]}')
                login_db = result[0]
                if login_db is None:
                    return 2
                else:
                    return 1
            except (Exception, psycopg2.Error) as error:
                print(f"login {login} не существует:", error)
                return 2
            finally:
                cursor.close()
                print('cursor closed')
                self.connection.commit()


    def check_password(self, login, pass_check):
        if self.connection is not None:
            cursor = self.connection.cursor()
            select_query = "SELECT password, id_user FROM logins WHERE login = %s"
            cond_for_select = (login,)
            try:
                cursor.execute(select_query, cond_for_select)
                result = cursor.fetchall()[0]
                pass_db = result[0]
                id_user = result[1]
                print(f'pass_db = {pass_db}')
                print(f'id_user = {id_user}')

                pass_hash = hashlib.md5(pass_check.encode("utf-8")).hexdigest()

                if pass_db == pass_hash:
                    print('Пароль правильный')
                    return id_user
                else:
                    print('Пароль неправильный!!!')
                    return 0
            except (Exception, psycopg2.Error) as error:
                print(f"login {login} не существует:", error)
                return 0
            finally:
                cursor.close()
                print('cursor closed')

    def add_user(self, **user_data):
        if self.connection is not None:
            cursor = self.connection.cursor()
            try:
                cursor.execute(
                    'INSERT INTO users (name, name_last, date_birth, sex, city, interests) VALUES (%s, %s, %s, %s, %s, %s) RETURNING id',
                    (user_data['name'], user_data['name_last'], user_data['date_birth'], user_data['sex'], user_data['city'], user_data['interests']))
                id_of_new_row = cursor.fetchone()[0]
                pass_hash = hashlib.md5(user_data['password'].encode("utf-8")).hexdigest()
                cursor.execute(
                    'INSERT INTO logins (id_user, login, password) VALUES (%s, %s, %s)',
                    (id_of_new_row, user_data['login'], pass_hash))
                self.connection.commit()
                return id_of_new_row
            except (Exception, psycopg2.Error) as error2:
                print(f"Не удалось вставить {user_data['name']} {user_data['name_last']}: ", error2)
            finally:
                cursor.close()
            return 0

    def get_user_data(self, id_user):
        if self.connection is not None:
            cursor = self.connection.cursor()
            select_query = "SELECT * FROM users WHERE id = %s"
            cond_for_select = (id_user,)
            try:
                cursor.execute(select_query, cond_for_select)
                user_data = cursor.fetchall()[0]
                print(f'user_data = {user_data}')
                user_data_obj = {
                    'id_user': user_data[0],
                    'name': user_data[1],
                    'name_last': user_data[2],
                    'date_birth': user_data[3].strftime("%d.%m.%Y"),
                    'sex': user_data[4],
                    'city': user_data[5],
                    'interests': user_data[6],
                }
                return user_data_obj
            except (Exception, psycopg2.Error) as error:
                print(f"id_user {id_user} не существует:", error)
                return {}
            finally:
                cursor.close()
                print('cursor closed')