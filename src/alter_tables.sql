create table job (
    name text not null,
    billable real not null
);
insert into job values
    ('calibrate', 1.5),
    ('clean', 0.5);
create table work (
    person text not null,
    job text not null
);
insert into work values
    ('mik', 'calibrate'),
    ('mik', 'clean'),
    ('mik', 'complain'),
    ('po', 'clean'),
    ('po', 'complain'),
    ('tay', 'complain');

-- [keep]
alter table job
add ident integer not null default -1;

update job
set ident = 1
where name = 'calibrate';

update job
set ident = 2
where name = 'clean';

select * from job;
-- [/keep]
