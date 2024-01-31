select distinct person
from work
where person not in (
    select distinct person
    from work
    where job = 'calibrate'
);
