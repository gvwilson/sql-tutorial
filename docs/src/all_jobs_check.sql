create table job (
    name text not null,
    billable real not null,
    check (billable > 0.0)
);
insert into job values ('calibrate', 1.5);
insert into job values ('reset', -0.5);
select * from job;
