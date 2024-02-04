.read src/create_work_job.sql
-- start
insert into job values
    ('calibrate', 1.5),
    ('clean', 0.5);
insert into work values
    ('mik', 'calibrate'),
    ('mik', 'clean'),
    ('mik', 'complain'),
    ('po', 'clean'),
    ('po', 'complain'),
    ('tay', 'complain');
-- end
select * from job;
.print
select * from work;
