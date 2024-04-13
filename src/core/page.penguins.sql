select
    species,
    sex,
    island
from penguins
order by species, sex, island
limit 10 offset 3;
