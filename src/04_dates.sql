/*
We now come to the uncomfortable hell that is date and time
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
