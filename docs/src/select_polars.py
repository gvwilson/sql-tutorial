import polars as pl

query = "select species, count(*) as num from penguins group by species;"
uri = "sqlite:///db/penguins.db"
df = pl.read_database_uri(query, uri, engine="adbc")
print(df)
