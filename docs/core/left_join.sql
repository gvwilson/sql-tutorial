.read create_work_job.sql
.read populate_work_job.sql

-- [keep]
select *
from work left join job
    on work.job = job.name;
-- [/keep]
