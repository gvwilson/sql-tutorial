select
    name,
    building
from department
where
    not exists (
        select 1
        from staff
        where dept = department.ident
    )
order by name;
