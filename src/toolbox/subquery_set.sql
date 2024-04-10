.read ../datamod/create_work_job.sql
.read ../datamod/populate_work_job.sql

-- [keep]
select distinct person
from work
where person not in (
    select distinct person
    from work
    where job = 'calibrate'
);
-- [/keep]
