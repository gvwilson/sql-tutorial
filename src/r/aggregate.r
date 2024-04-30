penguins |> 
  group_by(species) |> 
  summarise(avg_body_mas = mean(body_mass_g))
