select body_mass_g
from penguins
where
    body_mass_g > (
        select avg(body_mass_g)
        from penguins
    )
limit 5;
