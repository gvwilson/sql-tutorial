.read src/create_work_job.sql

-- start
select *
from work
where person not in ('mik', 'tay');
-- end
