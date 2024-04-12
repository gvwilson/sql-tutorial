.read ../core/create_work_job.sql
.read ../core/populate_work_job.sql

-- [keep]
select *
from work
where person not in ('mik', 'tay');
-- [/keep]
