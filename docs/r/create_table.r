library(DBI)

another_connection <- dbConnect(RSQLite::SQLite(), ':memory:')

table1 <- tibble(
  person = c('mik', 'mik', 'mik', 'po', 'po', 'tay'),
  job = c('calibrate', 'clean', 'complain', 'clean', 'complain', 'complain')
)

dbWriteTable(another_connection, "work", table1, row.names = FALSE, overwrite = TRUE)

work <- tbl(another_connection, "work")
