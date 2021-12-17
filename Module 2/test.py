import db_connections

connection = db_connections.PostgreSQL_connection(
    "postgres", "postgres", "290590", "127.0.0.1", "5432")

cursor = connection.cursor()

