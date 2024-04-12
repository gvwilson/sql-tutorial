.read lineage_setup.sql

-- [keep]
with recursive descendent as (
    select
        'Clemente' as person,
        0 as generations
    union all
    select
        lineage.child as person,
        descendent.generations + 1 as generations
    from descendent inner join lineage
        on descendent.person = lineage.parent
)

select
    person,
    generations
from descendent;
-- [/keep]
