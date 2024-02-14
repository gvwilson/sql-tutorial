create table size (
    s text not null
);
insert into size values ('light'), ('heavy');

create table weight (
    w text not null
);

select * from size full outer join weight;
