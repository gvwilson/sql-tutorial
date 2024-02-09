.read src/create_work_job.sql
.read src/populate_work_job.sql

-- [keep]
select *
from work cross join job;
-- [/keep]
