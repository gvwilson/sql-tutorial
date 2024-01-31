alter table penguins
add active integer not null default 1;

update penguins
set active = iif(species = 'Adelie', 0, 1);

select species, count(*) as num
from penguins
where active
group by species;
