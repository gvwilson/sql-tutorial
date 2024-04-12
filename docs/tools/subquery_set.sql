.read ../core/create_work_job.sql
.read ../core/populate_work_job.sql

-- [keep]
select distinct person
from work
where person not in (
    select distinct person
    from work
    where job = 'calibrate'
);
-- [/keep]
