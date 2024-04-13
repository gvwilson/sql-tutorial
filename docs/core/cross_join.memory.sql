.read create_work_job.sql
.read populate_work_job.sql

-- [keep]
select *
from work cross join job;
-- [/keep]
