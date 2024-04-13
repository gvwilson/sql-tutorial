.read create_work_job.sql
.read populate_work_job.sql

-- [keep]
select
    work.person,
    sum(job.billable) as pay
from work left join job
    on work.job = job.name
group by work.person;
-- [/keep]
