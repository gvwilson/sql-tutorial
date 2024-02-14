select distinct
    species,
    sex,
    island
from penguins
where island = 'Biscoe' and sex != 'FEMALE';
