create table job (
    ident integer primary key autoincrement,
    name text not null,
    billable real not null
);

create table person (
    ident integer primary key autoincrement,
    name text not null
);

create table work (
    person text not null,
    job text not null
);

create table new_work (
    person_id integer not null,
    job_id integer not null,
    foreign key(person_id) references person(ident),
    foreign key(job_id) references job(ident)
);

-- [keep]
drop table work;
alter table new_work rename to work;
-- [/keep]

.schema
