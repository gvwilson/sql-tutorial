select
    date((select julianday(min(started)) from experiment) + value) as some_day
from (
    select value from generate_series(
        (select 0),
        (select count(*) - 1 from experiment)
    )
)
limit 5;
