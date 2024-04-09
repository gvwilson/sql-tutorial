.read create_work_job.sql
.read populate_work_job.sql
.read update_work_job.sql

-- [keep]
delete from work
where person = 'tae';

select * from work;
-- [/keep]
