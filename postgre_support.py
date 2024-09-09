import psycopg2
#from psycopg2 import Error
import hashlib


class PostgreSupport:
    def __init__(self, user="postgres",
                 password="[e,f2006c]t;f]",
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

    def check_password(self, login, pass_check):
        if self.connection is not None:
            cursor = self.connection.cursor()
            select_query = """ SELECT password FROM OTUS.logins WHERE login = %s"""
            cond_for_select = (login,)
            try:
                cursor.execute(select_query, cond_for_select)
                result = cursor.fetchall()[0]
                print(f'result = {result[0]}')
                pass_db = result[0]
                pass_hash = hashlib.md5(pass_check.encode("utf-8")).hexdigest()

                if pass_db == pass_hash:
                    print('Пароль правильный')
                    return 1
                else:
                    print('Пароль неправильный!!!')
                    return 0
            except (Exception, Error) as error:
                print(f"login {login} не существует:", error)
                return 2
            finally:
                cursor.close()
                print('cursor closed')

    # def insert_new_value(self, id_uid, date_time, mnemonic, value, val_type, uom):
    #     if self.connection is not None:
    #         cursor = self.connection.cursor()
    #         try:
    #             id_param = self.get_id_param(param=mnemonic, val_type=val_type, uom=uom)
    #             if val_type == "double":
    #                 try:
    #                     cursor.execute(
    #                         'INSERT INTO witsml.datafloat (uid_id, param_id, value, source_timestamp) VALUES (%s, %s, %s, %s)',
    #                         (id_uid, id_param, value, date_time))
    #                     self.connection.commit()
    #                 except (Exception, Error) as error2:
    #                     print(f"Не удалось вставить {mnemonic} со значением {value}: ", error2)
    #
    #         except (Exception, Error) as err:
    #             print(
    #                 f'Не удалось записать {mnemonic} со значением {value} типа {val_type} и uom = {uom}, ошибка {err}')
    #         finally:
    #             cursor.close()