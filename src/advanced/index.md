---
title: "Advanced Features"
tagline: "When you need 'em, you need 'em."
---

## Blobs

[%inc blob.memory.sql %]
[%inc blob.memory.out %]

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
[%inc lab_log_schema.lab_log.sql %]
[%inc lab_log_schema.lab_log.out %]

## Storing JSON

[%inc json_in_table.lab_log.sql %]
[%inc json_in_table.lab_log.out %]

-   Store heterogeneous data as [%g json "JSON" %]-formatted text
    (with double-quoted strings)
    -   Database parses the text each time it is queried,
        so performance can be an issue
-   Can alternatively store as blob (`jsonb`)
    -   Can't view it directly
    -   But more efficient

## Select Fields from JSON

[%inc json_field.lab_log.sql %]
[%inc json_field.lab_log.out %]

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

[%inc json_array.lab_log.sql %]
[%inc json_array.lab_log.out %]

-   SQLite and other database managers have many [JSON manipulation functions][sqlite_json]
-   `json_array_length` gives number of elements in selected array
-   Subscripts start with 0
-   Characters outside 7-bit ASCII represented as Unicode escapes

## Unpacking JSON Arrays

[%inc json_unpack.lab_log.sql %]
[%inc json_unpack.lab_log.out %]

-   `json_each` is another table-valued function
-   Use <code>json_each.<em>name</em></code> to get properties of unpacked array

## Exercise {: .exercise}

Write a query that counts how many times each person appears
in the first log entry associated with any piece of equipment.

## Selecting the Last Element of an  Array

[%inc json_array_last.lab_log.sql %]
[%inc json_array_last.lab_log.out %]

## Modifying JSON

[%inc json_modify.lab_log.sql %]
[%inc json_modify.lab_log.out %]

-   Updates the in-memory copy of the JSON, *not* the database record
-   Please use `json_quote` rather than trying to format JSON with string operations

## Exercise {: .exercise}

As part of cleaning up the lab log database,
replace the machine names in the JSON records in `usage`
with the corresopnding machine IDs from the `machine` table.

## Refreshing the Penguins Database {: .aside}

[%inc count_penguins.penguins.sql %]
[%inc count_penguins.penguins.out %]

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

## Hours Reminder {: .aside}

[%inc all_jobs.memory.sql %]
[%inc all_jobs.memory.out %]

## Adding Checks

[%inc all_jobs_check.sql %]
[%inc all_jobs_check.out %]

-   `check` adds constraint to table
    -   Must produce a Boolean result
    -   Run each time values added or modified
-   But changes made before the error have taken effect

## Exercise {: .exercise}

Rewrite the definition of the `penguins` table to add the following constraints:

1.  `body_mass_g` must be null or non-negative.

2.  `island` must be one of `"Biscoe"`, `"Dream"`, or `"Torgersen"`.
    (Hint: the `in` operator will be useful here.)

## ACID {: .aside}

-   [%g atomic "Atomic" %]: change cannot be broken down into smaller ones (i.e., all or nothing)
-   [%g consistent "Consistent" %]: database goes from one consistent state to another
-   [%g isolated "Isolated" %]: looks like changes happened one after another
-   [%g durable "Durable" %]: if change takes place, it's still there after a restart

## Transactions

[%inc transaction.memory.sql %]
[%inc transaction.memory.out %]

-   Statements outside transaction execute and are committed immediately
-   Statement(s) inside transaction don't take effect until:
    -   `end transaction` (success)
    -   `rollback` (undo)
-   Can have any number of statements inside a transaction
-   But *cannot* nest transactions in SQLite
    -   Other databases support this

## Rollback in Constraints

[%inc rollback_constraint.sql %]
[%inc rollback_constraint.out %]

-   All of second `insert` rolled back as soon as error occurred
-   But first `insert` took effect

## Rollback in Statements

[%inc rollback_statement.sql %]
[%inc rollback_statement.out %]

-   Constraint is in table definition
-   Action is in statement

## Upsert

[%inc upsert.sql %]
[%inc upsert.out %]

-   [%g upsert "upsert" %] stands for "update or insert"
    -   Create if record doesn't exist
    -   Update if it does
-   Not standard SQL but widely implemented
-   Example also shows use of SQLite `.print` command

## Exercise {: .exercise}

Using the assay database,
write a query that adds or modifies people in the `staff` table as shown:

| personal | family | dept | age |
| -------- | ------ | ---- | --- |
| Pranay   | Khanna | mb   | 41  |
| Riaan    | Dua    | gen  | 23  |
| Parth    | Johel  | gen  | 27  |

## Normalization {: .aside}

-   First [%g normal_form "normal form" %] (1NF):
    every field of every record contains one indivisible value.

-   Second normal form (2NF) and third normal form (3NF):
    every value in a record that isn't a key depends solely on the key,
    not on other values.

-   [%g denormalization "Denormalization" %]: explicitly store values that could be calculated on the fly
    -   To simplify queries and/or make processing faster

## Creating Triggers

[%inc trigger_setup.sql %]

-   A [%g trigger "trigger" %] automatically runs before or after a specified operation
-   Can have side effects (e.g., update some other table)
-   And/or implement checks (e.g., make sure other records exist)
-   Add processing overhead…
-   …but data is either cheap or correct, never both
-   Inside trigger, refer to old and new versions of record
    as <code>old.<em>column</em></code> and <code>new.<em>column</em></code>

## Trigger Not Firing

[%inc trigger_successful.memory.sql mark=keep %]
[%inc trigger_successful.memory.out %]

## Trigger Firing

[%inc trigger_firing.sql mark=keep %]
[%inc trigger_firing.out %]

## Exercise {: .exercise}

Using the penguins database:

1.  create a table called `species` with columns `name` and `count`; and

2.  define a trigger that increments the count associated with each species
    each time a new penguin is added to the `penguins` table.

Does your solution behave correctly when several penguins are added
by a single `insert` statement?

## Representing Graphs {: .aside}

[%inc lineage_setup.sql %]
[%inc represent_graph.memory.sql mark=keep %]
[%inc represent_graph.memory.out %]

[% figure
   slug="recursive_lineage"
   img="recursive_lineage.svg"
   caption="lineage diagram"
   alt="box and arrow diagram showing who is descended from whom in the lineage database"
%]

## Exercise {: .exercise}

Write a query that uses a self join to find every person's grandchildren.

## Recursive Queries

[%inc recursive_lineage.memory.sql mark=keep %]
[%inc recursive_lineage.memory.out %]

-   Use a [%g recursive_cte "recursive CTE" %] to create a temporary table (`descendent`)
-   [%g base_case "Base case" %] seeds this table
-   [%g recursive_case "Recursive case" %] relies on value(s) already in that table and external table(s)
-   `union all` to combine rows
    -   Can use `union` but that has lower performance (must check uniqueness each time)
-   Stops when the recursive case yields an empty row set (nothing new to add)
-   Then select the desired values from the CTE

## Exercise {: .exercise}

Modify the recursive query shown above to use `union` instead of `union all`.
Does this affect the result?
Why or why not?

## Contact Tracing Database {: .aside}

[%inc contact_person.contacts.sql %]
[%inc contact_person.contacts.out %]
[%inc contact_contacts.contacts.sql %]
[%inc contact_contacts.contacts.out %]

[% figure
   slug="recursive_contacts"
   img="recursive_contacts.svg"
   caption="contact diagram"
   alt="box and line diagram showing who has had contact with whom"
%]

## Bidirectional Contacts

[%inc bidirectional.sql mark=keep %]
[%inc bidirectional.out %]

-   Create a [%g temporary_table "temporary table" %] rather than using a long chain of CTEs
    -   Only lasts as long as the session (not saved to disk)
-   Duplicate information rather than writing more complicated query

## Updating Group Identifiers

[%inc update_group_ids.sql mark=keep %]
[%inc update_group_ids.out %]

-   `new_ident` is minimum of own identifier and identifiers one step away
-   Doesn't keep people with no contacts

## Recursive Labeling

[%inc recursive_labeling.contacts.sql mark=keep %]
[%inc recursive_labeling.contacts.out %]

-   Use `union` instead of `union all` to prevent [%g infinite_recursion "infinite recursion" %]

## Exercise {: .exercise}

Modify the query above to use `union all` instead of `union` to trigger infinite recursion.
How can you modify the query so that it stops at a certain depth
so that you can trace its output?

## Check Understanding {: .aside}

[% figure
   slug="recursive_concept_map"
   img="recursive_concept_map.svg"
   caption="common table expressions"
   alt="box and arrow diagram showing concepts related to common table expressions in SQL"
%]
