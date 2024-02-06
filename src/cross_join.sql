.read src/create_work_job.sql
.read src/populate_work_job.sql

-- start
select *
from work cross join job;
-- end
