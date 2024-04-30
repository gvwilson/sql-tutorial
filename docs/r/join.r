does_calibrate <- work |> 
  filter(job == 'calibrate')

work |> 
  anti_join(does_calibrate, by = join_by(person)) |> 
  distinct(person) |> 
  collect() 
