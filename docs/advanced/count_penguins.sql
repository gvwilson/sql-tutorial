select
    species,
    count(*) as num
from penguins
group by species;
