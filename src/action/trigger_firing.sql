.read trigger_setup.sql

-- [keep]
insert into job values
('gene', 1.0),
('august', -1.0);
-- [/keep]

select * from job;
.print
select * from total;
