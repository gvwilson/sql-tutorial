.read trigger_setup.sql

-- [keep]
insert into job values
('gene', 1.5),
('august', 0.5),
('gene', 1.0);
-- [/keep]

select * from job;
.print
select * from total;
