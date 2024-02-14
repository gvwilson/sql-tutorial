import pandas as pd
import sqlite3

connection = sqlite3.connect("db/penguins.db")
query = "select species, count(*) as num from penguins group by species;"
df = pd.read_sql(query, connection)
print(df)
