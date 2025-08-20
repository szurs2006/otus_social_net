import psycopg2
import hashlib
from outbox import TransactionalOutbox
from datetime import datetime




def get_first(seq):
    if isinstance(seq, (tuple, list)):
        return get_first(seq[0])
    return seq


def get_zero_list(seq):
    return [get_first(i) for i in seq]


class PostgreSupport:
    # def __init__(self, user="serg",
    #              password="aiWgIDHKPdHr",
    #              host="postgres_db",
    #              port="5432",
    #              database="OTUS",
    #              ):
    # def __init__(self, user="serg",
    #              password="password",
    #              host="localhost",
    #              port="5433",
    #              database="postgres",
    #              ):
    def __init__(self, **connp):
        self.connection = None
        self.user = connp['user']
        self.password = connp['password']
        self.host = connp['host']
        self.port = connp['port']
        self.database = connp['database']
        self.outbox = None

        print(f'Postgres host = {self.host}, port = {self.port}')

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
            self.outbox = TransactionalOutbox()
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
                    (user_data['name'], user_data['name_last'], user_data['date_birth'], user_data['sex'],
                     user_data['city'], user_data['interests']))
                id_of_new_row = cursor.fetchone()[0]
                pass_hash = hashlib.md5(user_data['password'].encode("utf-8")).hexdigest()
                cursor.execute(
                    'INSERT INTO logins (id_user, login, password) VALUES (%s, %s, %s)',
                    (id_of_new_row, user_data['login'], pass_hash))
                self.connection.commit()
                return id_of_new_row
            except (Exception, psycopg2.Error) as error2:
                print(f"Не удалось вставить {user_data['name']} {user_data['name_last']}: ", error2)
                self.connection.rollback()
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

    def search_users(self, params):
        if self.connection is not None:
            cursor = self.connection.cursor()
            select_query = "SELECT * FROM public.users WHERE name LIKE %s AND name_last LIKE %s ORDER BY id"
            cond_for_select = (params['name'], params['last_name'])
            try:
                cursor.execute(select_query, cond_for_select)
                users_data = cursor.fetchall()
                print(f'users_data = {users_data}')
                return users_data
                # user_data = cursor.fetchall()[0]
                # print(f'user_data = {user_data}')
                # user_data_obj = {
                #     'id_user': user_data[0],
                #     'name': user_data[1],
                #     'name_last': user_data[2],
                #     'date_birth': user_data[3].strftime("%d.%m.%Y"),
                #     'sex': user_data[4],
                #     'city': user_data[5],
                #     'interests': user_data[6],
                # }
                # return user_data_obj
            except (Exception, psycopg2.Error) as error:
                print(f"Error:", error)
                return {}
            finally:
                cursor.close()
                print('cursor closed')

    def add_friend(self, **user_data):
        if self.connection is not None:
            cursor = self.connection.cursor()
            try:
                cursor.execute(
                    'INSERT INTO users_friends (id_user, id_friend) VALUES (%s, %s)',
                    (user_data['id_user'], user_data['id_friend']))
                self.connection.commit()
                return True
            except (Exception, psycopg2.Error) as error2:
                print(f"Не удалось вставить {user_data['id_user']} {user_data['id_friend']}: ", error2)
                self.connection.rollback()
            finally:
                cursor.close()
            return False

    def feed_friends_posts(self, params: dict):
        if self.connection is not None:
            cursor = self.connection.cursor()
            limit = 100
            if 'limit' in params:
                limit = params['limit']
            select_query = """SELECT up.*
                            FROM users_posts up, users_friends uf 
                            WHERE uf.id_user =  %s
                            AND uf.id_friend = up.id_user  
                            ORDER BY up.post_created, up.id_user LIMIT %s"""
            # cond_for_select = (params['id_user'], params['offset'], params['limit'])
            cond_for_select = (params['id_user'], limit)
            try:
                cursor.execute(select_query, cond_for_select)
                users_data = cursor.fetchall()
                print(f'users_data = {users_data}')
                return users_data

            except (Exception, psycopg2.Error) as error:
                print(f"Error:", error)
                return {}
            finally:
                cursor.close()
                print('cursor closed')

    def add_post(self, **user_data):
        if self.connection is not None:
            cursor = self.connection.cursor()
            try:
                cursor.execute(
                    'INSERT INTO users_posts (id_user, post) VALUES (%s, %s)',
                    (user_data['id_user'], user_data['new_post']))
                self.connection.commit()
                return True
            except (Exception, psycopg2.Error) as error2:
                print(f"Не удалось вставить {user_data['id_user']} {user_data['new_post']}: ", error2)
                self.connection.rollback()
            finally:
                cursor.close()
            return False

    def get_users_by_friend(self, id_friend):
        if self.connection is not None:
            cursor = self.connection.cursor()
            select_query = """SELECT id_user 
                            FROM users_friends uf 
                            WHERE id_friend =  %s  
                            """
            # cond_for_select = (params['id_user'], params['offset'], params['limit'])
            cond_for_select = (id_friend,)
            try:
                cursor.execute(select_query, cond_for_select)
                users_data = cursor.fetchall()
                print(f'users_data = {users_data}')
                if users_data is not None:
                    users_list = get_zero_list(list(users_data))
                    return users_list

            except (Exception, psycopg2.Error) as error:
                print(f"Error:", error)
                return {}
            finally:
                cursor.close()
                print('cursor closed')

    def add_dialog_text(self, **dialog_data):
        if self.connection is not None:

            id_from_user = dialog_data['from_user']
            id_to_user = dialog_data['to_user']
            dialog_text =dialog_data['dialog_text']
            str_for_hash = f"{id_from_user}_{id_to_user}".encode('utf-8')
            hash_object = hashlib.md5()
            hash_object.update(str_for_hash)
            hex_digest = hash_object.hexdigest()

            cursor = self.connection.cursor()
            try:
                cursor.execute(
                    'INSERT INTO dialogs (from_user, to_user, dtext, dist_key) VALUES (%s, %s, %s, %s) returning created_at',
                    (id_from_user, id_to_user, dialog_text, hex_digest))
                (message_created_at,) = cursor.fetchone()
                mesint_created_at = message_created_at.timestamp()
                self.outbox.add_event(
                    cursor,
                    event_type="message_created",
                    aggregate_id=str(id_to_user),
                    payload={
                        "message_created_at": mesint_created_at,
                        "id_from_user": id_from_user,
                        "id_to_user": id_to_user,
                        "delta": +1
                    }
                )
                self.connection.commit()
                return True
            except (Exception, psycopg2.Error) as error2:
                print(f"Не удалось вставить диалог для: from_user={id_from_user}, to_user= {id_to_user}, dialog_text={dialog_text}: ", error2)
                self.connection.rollback()
            finally:
                cursor.close()
            return False

    def mark_message_read(self, message_id: int, id_to_user: int):
        cursor = self.connection.cursor()
        try:
            dt = datetime.utcfromtimestamp(message_id)
            cursor.execute(
                'SELECT * FROM dialogs WHERE created_at = %s',
                (dt,))
            mes_data = cursor.fetchall()
            cursor.execute(
                'UPDATE dialogs SET is_read = true WHERE created_at = %s',
                (dt,))
            self.outbox.add_event(
                cursor,
                event_type="message_read",
                aggregate_id=str(id_to_user),
                payload={
                    "message_id": message_id,
                    "id_to_user": id_to_user,
                    "delta": -1
                }
            )
            self.connection.commit()
        except Exception:
            self.connection.rollback()
            raise
        finally:
            cursor.close()

    def get_dialogs_by_user_id(self, id_user):
        if self.connection is not None:
            cursor = self.connection.cursor()
            # select_query = "SELECT * FROM dialogs WHERE from_user = %s OR to_user = %s ORDER BY created_at"
            # cond_for_select = (id_user, id_user)

            # select_query = "SELECT * FROM dialogs ORDER BY created_at"


            select_query = "SELECT * FROM dialogs WHERE to_user = %s ORDER BY created_at"
            cond_for_select = (id_user,)
            try:
                cursor.execute(select_query, cond_for_select)
                # cursor.execute(select_query)
                user_dialogs = cursor.fetchall()
                list_dialogs = []
                for dialog in user_dialogs:
                    dstr = f'from_user = {dialog[0]}, to_user = {dialog[1]}, text = {dialog[2]}, created_at = {dialog[4]}, is_read = {dialog[5]}'
                    print(dstr)
                    message_created_at = dialog[4]
                    mesint_created_at = message_created_at.timestamp()
                    if dialog[5] is False:
                        self.mark_message_read(mesint_created_at, id_user)
                    list_dialogs.append(dstr)

                return list_dialogs
            except (Exception, psycopg2.Error) as error:
                print(f"id_user {id_user} не существует:", error)
                return {}
            finally:
                cursor.close()
                print('cursor closed')

    def refresh_feed_posts(self):
        if self.connection is not None:
            cursor = self.connection.cursor()
            try:
                cursor.execute(
                    'REFRESH MATERIALIZED VIEW CONCURRENTLY feed_posts;'
                    # 'REFRESH MATERIALIZED VIEW feed_posts;'
                )
                self.connection.commit()
            except (Exception, psycopg2.Error) as error2:
                print(f"Не удалось сделать refresh_feed_posts: ", error2)
                self.connection.rollback()
            finally:
                cursor.close()
            return 0

    def get_user_feed(self, id_user, timeout):
        if self.connection is not None:
            cursor = self.connection.cursor()
            if timeout > 0:
                select_query = "SELECT * FROM feed_posts WHERE id_user = %s AND post_created > now() - interval '%s seconds'"
                cond_for_select = (id_user, timeout,)
            else:
                select_query = "SELECT * FROM feed_posts WHERE id_user = %s"
                cond_for_select = (id_user,)
            try:
                cursor.execute(select_query, cond_for_select)
                self.connection.commit()
                user_data = cursor.fetchall()
                print(f'user_data = {user_data}')
                return user_data
            except (Exception, psycopg2.Error) as error:
                print(f"id_user {id_user} не существует:", error)
                return {}
            finally:
                cursor.close()
                print('cursor closed')