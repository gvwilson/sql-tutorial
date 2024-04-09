.read ../datamod/create_work_job.sql
.read ../datamod/populate_work_job.sql

-- [keep]
select *
from work cross join job;
-- [/keep]
