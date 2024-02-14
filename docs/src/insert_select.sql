create table job (
    ident integer primary key autoincrement,
    name text not null,
    billable real not null
);
insert into job values
(null, 'calibrate', 1.5),
(null, 'clean', 0.5);

create table person (
    ident integer primary key autoincrement,
    name text not null
);
insert into person values
(null, 'mik'),
(null, 'po'),
(null, 'tay');

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
create table new_work (
    person_id integer not null,
    job_id integer not null,
    foreign key (person_id) references person (ident),
    foreign key (job_id) references job (ident)
);

insert into new_work
select
    person.ident as person_id,
    job.ident as job_id
from
    (person inner join work on person.name = work.person)
    inner join job on job.name = work.job;
select * from new_work;
-- [/keep]
