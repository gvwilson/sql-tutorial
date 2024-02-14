select
    ident,
    json_array_length(log->'$') as length,
    log->'$[0]' as first
from usage;
