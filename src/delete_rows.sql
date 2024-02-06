.read src/create_work_job.sql
.read src/populate_work_job.sql
.read src/update_work_job.sql

-- start
delete from work
where person = "tae";

select * from work;
-- end
