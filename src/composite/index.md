---
title: "Composite Data"
tagline: "Binary data, JSON, and CSV import."
---

## Blobs

[%inc blob.sql %]
[%inc blob.out %]

-   A [%g blob "blob" %] is a binary large object
    -   Bytes in, bytes out…
-   If you think that's odd, check out [Fossil][fossil]

## Exercise {: .exercise}

Modify the query shown above to select the value of `content`
rather than its length.
How intelligible is the output?
Does using SQLite's `hex()` function make it any more readable?

## Yet Another Database {: .aside}

[%inc lab_log_db.sh %]
[%inc lab_log_schema.sql %]
[%inc lab_log_schema.out %]

## Storing JSON

[%inc json_in_table.sql %]
[%inc json_in_table.out %]

-   Store heterogeneous data as [%g json "JSON" %]-formatted text
    (with double-quoted strings)
    -   Database parses the text each time it is queried,
        so performance can be an issue
-   Can alternatively store as blob (`jsonb`)
    -   Can't view it directly
    -   But more efficient

## Select Fields from JSON

[%inc json_field.sql %]
[%inc json_field.out %]

-   Single arrow `->` returns JSON representation of result
-   Double arrow `->>` returns SQL text, integer, real, or null
-   Left side is column
-   Right side is [%g path_expression "path expression" %]
    -   Start with `$` (meaning "root")
    -   Fields separated by `.`

## Exercise {: .exercise}

Write a query that selects the year from the `"refurbished"` field
of the JSON data associated with the Inphormex plate reader.

## JSON Array Access

[%inc json_array.sql %]
[%inc json_array.out %]

-   SQLite and other database managers have many [JSON manipulation functions][sqlite_json]
-   `json_array_length` gives number of elements in selected array
-   Subscripts start with 0
-   Characters outside 7-bit ASCII represented as Unicode escapes

## Unpacking JSON Arrays

[%inc json_unpack.sql %]
[%inc json_unpack.out %]

-   `json_each` is another table-valued function
-   Use <code>json_each.<em>name</em></code> to get properties of unpacked array

## Exercise {: .exercise}

Write a query that counts how many times each person appears
in the first log entry associated with any piece of equipment.

## Selecting the Last Element of an  Array

[%inc json_array_last.sql %]
[%inc json_array_last.out %]

## Modifying JSON

[%inc json_modify.sql %]
[%inc json_modify.out %]

-   Updates the in-memory copy of the JSON, *not* the database record
-   Please use `json_quote` rather than trying to format JSON with string operations

## Exercise {: .exercise}

As part of cleaning up the lab log database,
replace the machine names in the JSON records in `usage`
with the corresopnding machine IDs from the `machine` table.

## Refreshing the Penguins Database {: .aside}

[%inc count_penguins.sql %]
[%inc count_penguins.out %]

-   We will restore full database after each example

## Tombstones

[%inc make_active.sql %]
[%inc active_penguins.sql mark=keep %]
[%inc active_penguins.out %]

-   Use a tombstone to mark (in)active records
-   Every query must now include it

## Importing CSV Data {: .aside}

-   SQLite and most other database managers have tools for importing and exporting [%g csv "CSV" %]
-   In SQLite:
    -   Define table
    -   Import data
    -   Convert empty strings to nulls (if desired)
    -   Convert types from text to whatever (not shown below)

[%inc create_penguins.sql %]

## Exercise {: .exercise}

What are the data types of the columns in the `penguins` table
created by the CSV import shown above?
How can you correct the ones that need correcting?

## Views

[%inc views.sql mark=keep %]
[%inc views.out %]

-   A [%g view "view" %] is a saved query that other queries can invoke
-   View is re-run each time it's used
-   Like a CTE, but:
    -   Can be shared between queries
    -   Views came first
-   Some databases offer [%g materialized_view "materialized views" %]
    -   Update-on-demand temporary tables

## Exercise {: .exercise}

Create a view in the lab log database called `busy` with two columns:
`machine_id` and `total_log_length`.
The first column records the numeric ID of each machine;
the second shows the total number of log entries for that machine.

## Check Understanding {: .aside}

[% figure
   slug="composite_temp_concept_map"
   img="composite_temp_concept_map.svg"
   caption="temporary tables"
   alt="box and arrow diagram showing different kinds of temporary 'tables' in SQL"
%]
