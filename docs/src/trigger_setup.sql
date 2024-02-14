-- Track hours of lab work.
create table job (
    person text not null,
    reported real not null check (reported >= 0.0)
);

-- Explicitly store per-person total rather than using sum().
create table total (
    person text unique not null,
    hours real
);

-- Initialize totals.
insert into total values
('gene', 0.0),
('august', 0.0);

-- Define a trigger.
create trigger total_trigger
before insert on job
begin
    -- Check that the person exists.
    select case
        when not exists (select 1 from total where person = new.person)
        then raise(rollback, 'Unknown person ')
    end;
    -- Update their total hours (or fail if non-negative constraint violated).
    update total
    set hours = hours + new.reported
    where total.person = new.person;
end;
