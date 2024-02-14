explain query plan
select
    species,
    avg(body_mass_g)
from penguins
group by species;
