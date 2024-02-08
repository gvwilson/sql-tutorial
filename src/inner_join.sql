.read src/create_work_job.sql
.read src/populate_work_job.sql

-- start
select *
from work inner join job
    on work.job = job.name;
-- end
