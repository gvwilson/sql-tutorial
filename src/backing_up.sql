.read src/create_work_job.sql
.read src/populate_work_job.sql
.read src/update_work_job.sql

-- start
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
-- end
