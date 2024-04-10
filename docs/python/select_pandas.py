import pandas as pd
import sqlite3
import sys

db_path = sys.argv[1]
connection = sqlite3.connect(db_path)
query = "select species, count(*) as num from penguins group by species;"
df = pd.read_sql(query, connection)
print(df)
