.read src/create_work_job.sql
.read src/populate_work_job.sql

-- [keep]
select distinct person
from work
where job != 'calibrate';
-- [/keep]
