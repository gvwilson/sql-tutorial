select
    work.person,
    sum(job.billable) as pay
from work inner join job
on work.job = job.name
group by work.person;
