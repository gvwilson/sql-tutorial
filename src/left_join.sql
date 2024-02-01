.read src/create_work_job.sql

-- start
select *
from work left join job
on work.job = job.name;
-- end
