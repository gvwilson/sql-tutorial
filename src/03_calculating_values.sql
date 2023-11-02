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

/*
Which brings us to the uncomfortable hell that is date and time
manipulation in SQLite. Unlike most databases, SQLite doesn't have a
special date-time datatype.  Instead, moments in time are represented
as:

- text in ISO-8601 format (such as 2023-01-25);
- numbers representing the Julian day (which is the number of days
  since November 24, 4714 BC); or
- seconds before or after January 1, 1970 (which is how Unix measures
  time).

To get the year in which each of the lab's machines was acquired, we
must use the `strftime` function to extract the year. (The "strf" in
`strftime` is borrowed from the C programming language, and is short
for "string format".)
*/

select
    mach_id,
    mach_name,
    strftime("%Y", acquired) as acq_year
from machines;

/*
However, `strftime` returns text. If we need a number, we need to
`cast` its output to an `integer`:
*/

select
    mach_id,
    mach_name,
    cast (strftime("%Y", acquired) as integer) as acq_year
from machines;

/*
The output looks the same, but we can now add or subtract years,
which we can't do with text.
*/
