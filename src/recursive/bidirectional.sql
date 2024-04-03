-- [keep]
create temporary table bi_contact (
    left text,
    right text
);

insert into bi_contact
select
    left, right from contact
    union all
    select right, left from contact
;
-- [/keep]

select count(*) as original_count from contact;
.print
select count(*) as num_contact from bi_contact;
