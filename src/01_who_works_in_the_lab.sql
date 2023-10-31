/*
 # Selecting Columns
*/

/*
 Our first query selects all of the data from the `scientists` table.
 We can put the whole query on a single line, but will break it across
 lines to make it more readable.
*/

select
    sci_id,
    personal,
    family,
    hired
from scientists;

/*
 Notice that Grace Barshan's hire date is empty. We're going to have
 to handle that specially later on.

 Let's make the output a bit more readable by putting SQLite in table
 mode:
*/

.mode table

select
    sci_id,
    personal,
    family,
    hired
from scientists;

/*
 We can use `*` to mean "all columns".
 (Notice that we don't need to use `.mode` again: SQLite stays in
 the mode we set until we end the session or set another mode.)
*/

select * from scientists;

/*
 Finally, we can select specific columns in whatever order we want:
*/

select
    family,
    personal,
    sci_id
from scientists;
