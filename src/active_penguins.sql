.read src/make_active.sql

-- start
select species, count(*) as num
from penguins
where active
group by species;
-- end
