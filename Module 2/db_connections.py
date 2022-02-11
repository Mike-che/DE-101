import psycopg2
from psycopg2 import Error

def PostgreSQL_connection(db_name, db_user, db_password, db_host, db_port):
    connection = None
    try:
        connection = psycopg2.connect(
            database=db_name,
            user=db_user,
            password=db_password,
            host=db_host,
            port=db_port,
        )
        print("Connection to PostgreSQL DB successful")
    except (Exception, Error) as error:
        print("Ошибка при работе с PostgreSQL", error)
    return connection