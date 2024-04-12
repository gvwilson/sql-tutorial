.read make_active.sql

-- [keep]
select
    species,
    count(*) as num
from penguins
where active
group by species;
-- [/keep]
