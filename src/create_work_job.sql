create table job (
    name text not null,
    billable real not null
);
create table work (
    person text not null,
    job text not null
);
