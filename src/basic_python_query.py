import sqlite3

connection = sqlite3.connect("db/penguins.db")
cursor = connection.execute("select count(*) from penguins;")
rows = cursor.fetchall()
print(rows)
