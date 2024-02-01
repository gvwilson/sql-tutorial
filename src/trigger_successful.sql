.read src/trigger_setup.sql

-- start
insert into job values
    ('gene', 1.5),
    ('august', 0.5),
    ('gene', 1.0)
;
-- end

select * from job;
.print
select * from total;
