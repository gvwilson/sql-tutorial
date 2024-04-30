work |> 
  filter(!person %in% sql(
    # subquery
    "(SELECT DISTINCT person FROM work
    where job = 'calibrate')"
  )) |> 
  distinct(person) 
