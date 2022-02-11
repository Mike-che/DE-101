import db_connections
from psycopg2 import Error
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

try:
    connection = db_connections.PostgreSQL_connection(
    "postgres", "postgres", "290590", "127.0.0.1", "5432")        
    connection.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)

    cursor = connection.cursor()
    cursor.execute('SELECT * FROM orders;')
    record = cursor.fetchmany(200)
    print(record, sep='\n')

except (Exception, Error) as error:
    print("Ошибка при работе с PostgreSQL", error)

finally:
    if connection:
        cursor.close()
        connection.close()
        print("Соединение с PostgreSQL закрыто")