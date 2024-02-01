with
person as (
    select
        ident,
        personal || ' ' || family as name
    from staff
),
together as (
    select
        left.staff as left_staff,
        right.staff as right_staff
    from performed as left join performed as right
    on left.experiment = right.experiment
    where left_staff < right_staff
)
select
    left.name as person_1,
    right.name as person_2
from person as left join person as right join together
on left.ident = left_staff and right.ident = right_staff;
