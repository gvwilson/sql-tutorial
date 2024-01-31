select
    left.species,
    left.body_mass_g,
    round(right.avg_mass_g, 1) as avg_mass_g
from penguins as left join (
    select species, avg(body_mass_g) as avg_mass_g
    from penguins
    group by species
) as right
where left.body_mass_g > right.avg_mass_g
limit 5;
