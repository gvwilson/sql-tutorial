create table person (
    ident integer primary key autoincrement,
    name text not null
);
insert into person values
(null, 'mik'),
(null, 'po'),
(null, 'tay');
select * from person;
insert into person values (1, 'prevented');
