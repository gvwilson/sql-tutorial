select
    ident,
    log->'$[#-1].machine' as final
from usage
limit 5;
