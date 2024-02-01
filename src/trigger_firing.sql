.read src/trigger_setup.sql

-- start
insert into job values
    ('gene', 1.0),
    ('august', -1.0)
;
-- end

select * from job;
.print
select * from total;
