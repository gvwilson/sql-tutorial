with sized_penguins as (
    select
        species,
        iif(
            body_mass_g < 3500,
            'small',
            'large'
        ) as size
    from penguins
)

select
    species,
    size,
    count(*) as num
from sized_penguins
group by species, size
order by species, num;
