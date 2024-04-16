select
    details->'$.acquired' as single_arrow,
    details->>'$.acquired' as double_arrow
from machine;
