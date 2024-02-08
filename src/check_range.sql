with sized_penguins as (
    select
        species,
        case
            when body_mass_g between 3500 and 5000 then 'normal'
            else 'abnormal'
        end as size
    from penguins
)

select
    species,
    size,
    count(*) as num
from sized_penguins
group by species, size
order by species, num;
