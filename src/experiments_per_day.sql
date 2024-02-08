with
-- complete sequence of days with 0 as placeholder for number of experiments
all_days as (
    select
        date((select julianday(min(started)) from experiment) + value) as some_day,
        0 as zeroes
    from (
        select value from generate_series(
            (select 0),
            (select count(*) - 1 from experiment)
        )
    )
),

-- sequence of actual days with actual number of experiments started
actual_days as (
    select
        started,
        count(started) as num_exp
    from experiment
    group by started
)

-- combined by joining on day and taking actual number (if available) or zero
select
    all_days.some_day as day,
    coalesce(actual_days.num_exp, all_days.zeroes) as num_exp
from
    all_days left join actual_days on all_days.some_day = actual_days.started
limit 5;
