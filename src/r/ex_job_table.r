table2 <- tibble(
  name = c('calibrate', 'clean'),
  billable = c(1.5, 0.5)
)

dbWriteTable(another_connection, "job", table2, row.names = FALSE, overwrite = TRUE)

job <- tbl(another_connection, "job")
