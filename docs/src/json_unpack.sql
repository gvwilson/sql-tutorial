select
    ident,
    json_each.key as key,
    json_each.value as value
from usage, json_each(usage.log)
limit 10;
