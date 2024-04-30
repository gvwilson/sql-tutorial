connection <- DBI::dbConnect(RSQLite::SQLite(), 'data/penguins.db')
DBI::dbListTables(connection)
