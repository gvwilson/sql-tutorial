with sized_penguins as (
    select
        species,
        case
            when body_mass_g < 3500 then 'small'
            when body_mass_g < 5000 then 'medium'
            else 'large'
        end as size
    from penguins
)
select species, size, count(*) as num
from sized_penguins
group by species, size
order by species, num;
