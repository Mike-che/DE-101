import psycopg2
 
# Подключиться к базе данных
conn = psycopg2.connect(
    database = 'postgres',
    user = 'postgres',
    password = '290590',
    host = '127.0.0.1',
    port = 5432
)
print("database opened successfully")

