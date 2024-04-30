work |> 
  filter(job != 'calibrate') |> 
  distinct(person)
