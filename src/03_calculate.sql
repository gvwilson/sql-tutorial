/*
We can calculate new values as we select data.  For example, here are
all the calibration readings the scientists have recorded:
*/

select * from readings;

/*
If we want to display readings as percentages, we just multiply that
column by 100:
*/

select
    exp_id,
    quantity,
    measured * 100
from readings;

/*
Notice that we have to give the names of all the columns we want: we
can't just use `*` because we don't want all the columns as they are.
Notice also that the third column's name isn't very friendly; we can
change it using `as`:
*/

select
    exp_id,
    quantity,
    measured * 100 as measured_pct
from readings;

/*
Calculations can be as simple or as complex as we want. For example,
we can use the `substr` (substring) function and the `||` operator
(which concatenates strings) to create a 2-letter ID for each
scientist:
*/

select
    personal,
    family,
    substr(personal, 1, 1) || substr(family, 1, 1) as initials
from scientists;
