.read src/create_work_job.sql
.read src/populate_work_job.sql

-- start
select *
from work
where person not in ('mik', 'tay');
-- end
