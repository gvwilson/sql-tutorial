with person as (
    select
        ident,
        personal || ' ' || family as name
    from staff
)
select left.name, right.name
from person as left join person as right
limit 10;
