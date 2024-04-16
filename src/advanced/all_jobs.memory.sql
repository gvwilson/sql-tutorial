create table job (
    name text not null,
    billable real not null
);
insert into job values
('calibrate', 1.5),
('clean', 0.5);
select * from job;
