.read create_work_job.sql
.read populate_work_job.sql
.read update_work_job.sql

-- [keep]
create table backup (
    person text not null,
    job text not null
);

insert into backup
select
    person,
    job
from work
where person = 'tae';

delete from work
where person = 'tae';

select * from backup;
-- [/keep]
