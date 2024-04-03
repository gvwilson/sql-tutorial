import sqlite3

connection = sqlite3.connect("db/penguins.db")
cursor = connection.cursor()
cursor = cursor.execute("select species, island from penguins limit 5;")
while row := cursor.fetchone():
    print(row)
