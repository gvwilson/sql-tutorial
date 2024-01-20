create table person(
    ident integer primary key autoincrement,
    name text not null
);
insert into person values
    (null, "mik"),
    (null, "po"),
    (null, "tay")
;
select * from person;

--

alter table job
add ident integer not null default -1;

update job
set ident = 1
where name = "calibrate";

update job
set ident = 2
where name = "clean";

select * from job;

--

create table new_work(
    person_id integer not null,
    job_id integer not null,
    foreign key(person_id) references person(ident),
    foreign key(job_id) references job(ident)
);

insert into new_work
select
    person.ident as person_id,
    job.ident as job_id
from
    (person join work on person.name = work.person)
    join job on job.name = work.job
;
select * from new_work;

---

drop table work;
alter table new_work rename to work;
.schema
