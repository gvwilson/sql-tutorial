work |> 
  left_join(job, by = join_by(job == name)) |> 
  group_by(person) |> 
  summarise(total_hours = sum(billable))
