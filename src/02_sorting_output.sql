/*
## Sorting Output
*/

.mode table

/*
We can sort by any column we want:
*/

select * from scientists
order by personal;

/*
or by a combination of columns:
*/

select
    sci_id,
    family,
    personal,
    hired
from scientists
order by family, personal;

/*
We can also sort in ascending (`asc`) or descending (`desc`) order:
the default is ascending (2 comes after 1, "B" comes after "A").
*/

select * from scientists
order by family desc;
