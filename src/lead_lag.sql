with ym_num as (
    select
        strftime('%Y-%m', started) as ym,
        count(*) as num
    from experiment
    group by ym
)

select
    ym,
    lag(num) over (order by ym) as prev_num,
    num,
    lead(num) over (order by ym) as next_num
from ym_num
order by ym;
