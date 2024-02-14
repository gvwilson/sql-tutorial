create table job (
    name text not null,
    billable real not null,
    check (billable > 0.0)
);

insert into job values ('calibrate', 1.5);

begin transaction;
insert into job values ('clean', 0.5);
rollback;

select * from job;
