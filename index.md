---
home: true
---
<section class="aside" markdown="1">

## setup

-   Download the ZIP file containing [the SQLite databases used in the examples][release]
-   Unzip the file in a temporary directory

</section>
<section class="aside" markdown="1">

## connect to database

{% include miscfile.md file="src/connect_penguins.sh" %}

-   Not actually a query
-   But we have to do it before we can do anything else

</section>
<section markdown="1">

## 001: select constant

{% include without.md file="select_1.sql" %}

-   `select` is a keyword
-   Normally used to select data from table…
-   …but if all we want is a constant value, we don't need to specify one
-   Semi-colon terminator is required

</section>
<section markdown="1">

## 002: select all values from table

{% include without.md file="select_star.sql" %}

-   Use `*` to mean "all columns"
-   Use <code>from <em>tablename</em></code> to specify table
-   Output format is not particularly readable

</section>
<section class="aside" markdown="1">

## administrative commands

{% include without.md file="admin_commands.sql" %}

-   SQLite administrative commands start with `.` and *aren't* part of the SQL standard
    -   PostgreSQL's special commands start with `\`
-   Use `.help` for a complete list

</section>
<section markdown="1">

## 003: specify columns

{% include without.md file="specify_columns.sql" %}

-   Specify column names separated by commas
    -   In any order
    -   Duplicates allowed
-   Line breaks <strike>allowed</strike> encouraged for readability

</section>
<section markdown="1">

## 004: sort

{% include without.md file="sort.sql" %}

-   `order by` must follow `from` (which must follow `select`)
-   `asc` is ascending, `desc` is descending
    -   Default is ascending, but please specify

</section>
<section markdown="1">

## 005: limit output

-   Full dataset has 344 rows

{% include without.md file="limit.sql" %}

-   Comments start with `--` and run to the end of the line
-   <code>limit <em>N</em></code> specifies maximum number of rows returned by query

</section>
<section markdown="1">

## 006: page output

{% include without.md file="page.sql" %}

-   <code>offset <em>N</em></code> must follow `limit`
-   Specifies number of rows to skip from the start of the selection
-   So this query skips the first 3 and shows the next 10

</section>
<section markdown="1">

## 007: remove duplicates

{% include without.md file="distinct.sql" %}

-   `distinct` keyword must appear right after `select`
    -   SQL was supposed to read like English
-   Shows distinct combinations
-   Blanks in `sex` column show missing data
    -   We'll talk about this in a bit

</section>
<section markdown="1">

## 008: filter results

{% include without.md file="filter.sql" %}

-   <code>where <em>condition</em></code> _filters_ the rows produced by selection
-   Condition is evaluated independently for each row
-   Only rows that pass the test appear in results
-   Use single quotes for `'text data'` and double quotes for `"weird column names"`
    -   SQLite will accept double-quoted text data

</section>
<section markdown="1">

## 009: filter with more complex conditions

{% include without.md file="filter_and.sql" %}

-   `and`: both sub-conditions must be true
-   `or`: either or both part must be true
-   Notice that the row for Gentoo penguins on Biscoe island with unknown (empty) sex didn't pass the test
    -   We'll talk about this in a bit

</section>
<section markdown="1">

## 010: do calculations

{% include without.md file="calculations.sql" %}

-   Can do the usual kinds of arithmetic on individual values
    -   Calculation done for each row independently
-   Column name shows the calculation done

</section>
<section markdown="1">

## 011: rename columns

{% include without.md file="rename_columns.sql" %}

-   Use <code><em>expression</em> as <em>name</em></code> to rename
-   Give result of calculation a meaningful name
-   Can also rename columns without modifying

</section>
<section class="aside" markdown="1">

## check your understanding

![concept map: selection](./img/concept_map_select.svg)

</section>
<section markdown="1">

## 012: calculate with missing values
{% include without.md file="show_missing_values.sql" %}

-   SQL uses a special value `null` to representing missing data
    -   Not 0 or empty string, but "I don't know"
-   Flipper length and body weight not known for one of the first five penguins
-   "I don't know" divided by 10 or 1000 is "I don't know"

</section>
<section markdown="1">

## 013: null equality

-   Repeated from above so it doesn't count against our query limit

{% include without.md file="filter.sql" %}

-   If we ask for female penguins the row with the missing sex drops out

{% include without.md file="null_equality.sql" %}

</section>
<section markdown="1">

## 014: null inequality

-   But if we ask for penguins that *aren't* female it drops out as well

{% include without.md file="null_inequality.sql" %}

</section>
<section markdown="1">

## 015: ternary logic

{% include without.md file="ternary_logic.sql" %}

-   If we don't know the left and right values, we don't know if they're equal or not
-   So the result is `null`
-   Get the same answer for `null != null`
-   _Ternary logic_

<table>
  <tr>
    <th colspan="4">equality</th>
  </tr>
  <tr>
    <th></th>
    <th>X</th>
    <th>Y</th>
    <th>null</th>
  </tr>
  <tr>
    <th>X</th>
    <td>true</td>
    <td>false</td>
    <td>null</td>
  </tr>
  <tr>
    <th>Y</th>
    <td>false</td>
    <td>true</td>
    <td>null</td>
  </tr>
  <tr>
    <th>null</th>
    <td>null</td>
    <td>null</td>
    <td>null</td>
  </tr>
</table>

</section>
<section markdown="1">

## 016: handle null safely

{% include without.md file="safe_null_equality.sql" %}

-   Use `is null` and `is not null` to handle null safely
-   Other parts of SQL handle nulls specially

</section>
<section class="aside" markdown="1">

## check your understanding

![concept map: null](./img/concept_map_null.svg)

</section>
<section markdown="1">

## 017: aggregate

{% include without.md file="simple_sum.sql" %}

-   `sum` is an _aggregation function_
-   Combines corresponding values from multiple rows

</section>
<section markdown="1">

## 018: common aggregation functions

{% include without.md file="common_aggregations.sql" %}

-   This actually shouldn't work:
    can't calculate maximum or average if any values are null
-   SQL does the useful thing instead of the right one

</section>
<section markdown="1">

## 019: group

{% include without.md file="simple_group.sql" %}

-   Put rows in _groups_ based on distinct combinations of values in columns specified with `group by`
-   Then perform aggregation separately for each group
-   But which is which?

</section>
<section markdown="1">

## 020: behavior of unaggregated columns

{% include without.md file="unaggregated_columns.sql" %}

-   All rows in each group have the same value for `sex`, so no need to aggregate

</section>
<section markdown="1">

## 021: arbitrary choice in aggregation

{% include without.md file="arbitrary_in_aggregation.sql" %}

-   If we don't specify how to aggregate a column, SQL can choose *any arbitrary value* from the group
-   All penguins in each group have the same sex because we grouped by that, so we get the right answer
-   The body mass values are in the data but unpredictable
-   A common mistake

</section>
<section markdown="1">

## 022: filter aggregated values

{% include without.md file="filter_aggregation.sql" %}

-   Using <code>having <em>condition</em></code> instead of <code>where <em>condition</em></code> for aggregates

</section>
<section markdown="1">

## 023: readable output

{% include without.md file="readable_aggregation.sql" %}

-   Use <code>round(<em>value</em>, <em>decimals</em>)</code> to round off a number

</section>
<section markdown="1">

## 024: filter aggregate inputs

{% include without.md file="filter_aggregate_inputs.sql" %}

-   <code>filter (where <em>condition</em>)</code> applies to *inputs*

</section>
<section class="aside" markdown="1">

## check your understanding

![concept map: null](./img/concept_map_aggregate.svg)

</section>
<section class="aside" markdown="1">

## create in-memory database

{% include miscfile.md file="src/in_memory_db.sh" %}

-   "Connect" to an _in-memory database_

</section>
<section markdown="1">

## 025: create tables

{% include miscfile.md file="src/create_work_job.sql" %}
{% include miscfile.md file="out/show_work_job.out" %}

-   <code>create table <em>name</em></code> followed by parenthesized list of columns
-   Each column is a name, a data type, and optional extra information
    -   E.g., `not null` prevents nulls from being added
-   `.schema` is *not* standard SQL
-   SQLite has added a few things
    -   `create if not exists`
    -   upper-case keywords (SQL is case insensitive)

</section>
<section markdown="1">

## 026: insert data

{% include without.md file="insert_values.sql" %}

</section>
<section markdown="1">

## 027: update rows

{% include without.md file="update_rows.sql" %}

</section>
<section markdown="1">

## 028: delete rows

{% include without.md file="delete_rows.sql" %}

</section>
<section markdown="1">

## 029: backing up

{% include without.md file="backing_up.sql" %}

</section>
<section markdown="1">

## 030: join tables

{% include without.md file="cross_join.sql" %}

-   `cross join` (also called _outer join_) constructs cross product of tables
    -   All combinations of rows from each
-   Result isn't particularly useful: `job` and `name` don't match

</section>
<section markdown="1">

## 031: inner join

{% include without.md file="inner_join.sql" %}

-   Use <code><em>table</em>.<em>column</em></code> notation to specify columns
    -   A column can have the same name as a table
-   Use <code>on <em>condition</em></code> to specify _join condition_
-   Since `complain` doesn't appear in `job.name`, none of those rows are kept

</section>
<section markdown="1">

## 032: aggregate joined data

{% include without.md file="aggregate_join.sql" %}

-   Combines ideas we've seen before
-   But Tay is missing from the table

</section>
<section markdown="1">

## 033: left join

{% include without.md file="left_join.sql" %}

-   A _left outer join_ keeps all rows from the left table
-   Fills missing values from right table with null

</section>
<section markdown="1">

## 034: aggregate left joins

{% include without.md file="aggregate_left_join.sql" %}

-   That's better, but we'd like to see 0 rather than a blank

</section>
<section markdown="1">

## 035: coalesce values

{% include without.md file="coalesce.sql" %}

-   <code>coalesce(<em>val1</em>, <em>val2</em>, …)</code> returns first non-null value

</section>
<section markdown="1">

## 036: negate incorrectly

-   Who doesn't calibrate?

{% include without.md file="negate_incorrectly.sql" %}

-   But Mik *does* calibrate
-   Problem is that there's an entry for Mik cleaning
-   And since `'clean' != 'calibrate'`, that row is included in the results
-   We need a different approach

</section>
<section markdown="1">

## 037: set membership

{% include without.md file="set_membership.sql" %}

-   <code>in <em>values</em></code> and <code>not in <em>values</em></code> do exactly what you expect

</section>
<section markdown="1">

## 038: subqueries

{% include without.md file="subquery_set.sql" %}

-   Use a _subquery_ to select the people who *do* calibrate
-   Then select all the people who aren't in that set
-   Initially feels odd, but subqueries are useful in other ways

</section>
<section class="aside" markdown="1">

## M to N relationships

-   Relationships between entities are usually characterized as:
    -   1-to-1: fields in the same record
    -   1-to-many: the many have a _foreign key_ referring to the one's _primary key_
    -   many-to-many: don't know how many keys to add to records ("maximum" never is)
-   Nearly-universal solution is a _join table_
    -   Each record is a pair of foreign keys
    -   I.e., each record is the fact that records A and B are related

</section>
<section markdown="1">

## 039: autoincrement and primary key

{% include without.md file="autoincrement.sql" %}

-   Database _autoincrements_ `ident` each time a new record is added
-   Use that field as the primary key
    -   So that if Mik changes their name again,
        we only have to change one fact in the database
    -   Downside: manual queries are harder to read (who is person 17?)

</section>
<section class="aside" markdown="1">

## internal tables

{% include without.md file="sequence_table.sql" %}

-   Sequence numbers are *not* reset when rows are deleted

</section>
<section markdown="1">

## 040: alter tables

{% include without.md file="alter_tables.sql" %}

-   Add a column after the fact
-   Since it can't be null, we have to provide a default value
    -   Really want to make it the primary key, but SQLite doesn't allow that (easily) after the fact
-   Then use `update` to modify existing records
    -   Can modify any number of records at once
    -   So be careful about `where` clause
-   _Data migration_

</section>
<section markdown="1">

## 041: create new tables from old

{% include without.md file="insert_select.sql" %}

-   `new_work` is our join table
-   Each column refers to a record in some other table

</section>
<section markdown="1">

## 042: remove tables

{% include without.md file="drop_table.sql" %}

-   Remove the old table and rename the new one to take its place
    -   Note `if exists`
-   Be careful…

</section>
<section markdown="1">

## 043: compare individual values to aggregates

-   Go back to penguins

{% include without.md file="compare_individual_aggregate.sql" %}

-   Get average body mass in subquery
-   Compare each row against that
-   Requires two scans of the data, but there's no way to avoid that
-   Null values aren't included in the average or in the final results

</section>
<section markdown="1">

## 044: compare individual values to aggregates within groups

{% include without.md file="compare_within_groups.sql" %}

</section>
<section markdown="1">

## 045: common table expressions

{% include without.md file="common_table_expressions.sql" %}

-   Use _common table expression_ (CTE) to make queries clearer
    -   Nested subqueries quickly become difficult to understand
-   Database decides how to optimize

</section>
<section class="aside" markdown="1">

## explain query plan

{% include without.md file="explain_query_plan.sql" %}

-   SQLite plans to scan every row of the table
-   It will build a temporary B-tree data structure to group rows

</section>
<section markdown="1">

## 046: enumerate rows

-   Every table has a special column called `rowid`

{% include without.md file="rowid.sql" %}

-   `rowid` is persistent within a session
    -   I.e., if we delete the first 5 rows we now have row IDs 6…N
-   *Do not rely on row ID*
    -   In particular, do not use it as a key

</section>
<section markdown="1">

## 047: if-else function

{% include without.md file="if_else.sql" %}

-   <code>iif(<em>condition</em>, <em>true_result</em>, <em>false_result</em>)</code>
    -   Note: `iif` with two i's

</section>
<section markdown="1">

## 048: select a case

-   What if we want small, medium, and large?
-   Can nest `iif`, but quickly becomes unreadable

{% include without.md file="case_when.sql" %}

-   Evaluate `when` options in order and take first
-   Result of `case` is null if no condition is true
-   Use `else` as fallback

</section>
<section markdown="1">

## 049: check range

{% include without.md file="check_range.sql" %}

-   `between` can make queries easier to read
-   But be careful of the `and` in the middle

</section>
<section class="aside" markdown="1">

## yet another database

-   _Entity-relationship diagram_ (ER diagram) shows relationships between tables
-   Like everything to do with databases, there are lots of variations

![assay database table diagram](./img/assays_tables.svg)

![assay ER diagram](./img/assays_er.svg)

{% include without.md file="assay_staff.sql" %}

</section>
<section markdown="1">

## 050: pattern matching

{% include without.md file="like_glob.sql" %}

-   `like` is the original SQL pattern matcher
    -   `%` matches zero or more characters at the start or end of a string
    -   Case insensitive by default
-   `glob` supports Unix-style wildcards

| name      | purpose |
| --------- | ------- |
| `substr`  | Get substring given starting point and length |
| `trim`    | Remove characters from beginning and end of string |
| `ltrim`   | Remove characters from beginning of string |
| `rtrim`   | Remove characters from end of string |
| `length`  | Length of string |
| `replace` | Replace occurrences of substring with another string |
| `upper`   | Return upper-case version of string |
| `lower`   | Return lower-case version of string |
| `instr`   | Find location of first occurrence of substring (returns 0 if not found) |

</section>
<section markdown="1">

## 051: select first and last rows

{% include without.md file="union_all.sql" %}

-   `union all` combines records
    -   Keeps duplicates: `union` on its own keeps unique records
-   Yes, it feels like the extra `select * from` should be unnecessary

</section>
<section markdown="1">

## 052: intersection

{% include without.md file="intersect.sql" %}

-   Tables being intersected must have same structure
-   Intersection usually used when pulling values from different tables
    -   In this case, would be clearer to use `where`

</section>
<section markdown="1">

## 053: exclusion

{% include without.md file="except.sql" %}

-   Again, tables must have same structure
    -   And this would be clearer with `where`
-   SQL operates on sets, not tables, except where it doesn't

</section>
<section markdown="1">

## 054: random numbers and why not

{% include without.md file="random_numbers.sql" %}

-   There is no way to seed SQLite's random number generator
-   Which means there is no way to reproduce one of its "random" sequences

</section>
<section markdown="1">

## 055: generate sequence

{% include without.md file="generate_sequence.sql" %}

-   A (non-standard) _table-valued function_

</section>
<section markdown="1">

## 056: generate sequence based on data

{% include without.md file="data_range_sequence.sql" %}

-   Must have the parentheses around the `min` and `max` selections to keep SQLite happy

</section>
<section markdown="1">

## 057: generate sequence of dates

{% include without.md file="date_sequence.sql" %}

-   SQLite represents dates as YYYY-MM-DD strings
    or as Julian days or as Unix milliseconds or…
    -   Julian days is fractional number of days since November 24, 4714 BCE
-   `julianday` and `date` convert back and forth

</section>
<section markdown="1">

## 058: count experiments started per day without gaps

{% include without.md file="experiments_per_day.sql" %}

</section>
<section markdown="1">

## 059: self join

{% include without.md file="self_join.sql" %}

-   Join a table to itself
    -   Give copies aliases using `as` to distinguish them
    -   Nothing special about the name `left` and `right`
-   Get all <math>n<sup>2</sup></math> pairs, including person with themself

</section>
<section markdown="1">

## 060: generate unique pairs

{% include without.md file="unique_pairs.sql" %}

-   `left.ident < right.ident` ensures distinct pairs without duplicates
-   Use `left.ident <= 4 and right.ident <= 4` to limit output
-   Quick check: <math>n(n-1)/2</math> pairs

</section>
<section markdown="1">

## 061: filter pairs

{% include without.md file="filter_pairs.sql" %}

</section>
<section markdown="1">

## 062: existence and correlated subqueries

{% include without.md file="correlated_subquery.sql" %}

-   Nobody works in Endocrinology
-   `select 1` could equally be `select true` or any other value
-   A _correlated subquery_ depends on a value from the outer query
    -   Equivalent to nested loop

</section>
<section markdown="1">

## 063: nonexistence

{% include without.md file="nonexistence.sql" %}

</section>
<section class="aside" markdown="1">

## avoiding correlated subqueries

{% include without.md file="avoid_correlated_subqueries.sql" %}

-   The join might or might not be faster than the correlated subquery
-   Hard to find unstaffed departments without either `not exists` or `count` and a check for 0

</section>
<section markdown="1">

## 064: lead and lag

{% include without.md file="lead_lag.sql" %}

-   Use `strftime` to extract year and month
    -   Clumsy, but date/time handling is not SQLite's strong point
-   Use _window functions_ `lead` and `lag` to shift values
    -   Unavailable values are null

</section>
<section markdown="1">

## 065: window functions

{% include without.md file="window_functions.sql" %}

-   `sum() over` does a running total
-   `cume_dist` is fraction *of rows seen so far*

</section>
<section class="aside" markdown="1">

## explain another query plain

{% include without.md file="explain_window_function.sql" %}

-   Becomes useful…eventually

</section>
<section markdown="1">

## 066: partitioned windows

{% include without.md file="partition_window.sql" %}

-   `partition by` creates groups
-   So this counts experiments started since the beginning of each year

</section>
<section markdown="1">

## 067: blobs

{% include without.md file="blob.sql" %}

-   A _blob_ is a binary large object
    -   Bytes in, bytes out…
-   If you think that's odd, check out [Fossil][fossil]

</section>
<section class="aside" markdown="1">

## yet another database

{% include miscfile.md file="src/lab_log_db.sh" %}
{% include without.md file="lab_log_schema.sql" %}

</section>
<section markdown="1">

## 068: store JSON

{% include without.md file="json_in_table.sql" %}

-   Store heterogeneous data as JSON-formatted text (with double-quoted strings)
    -   Database parses it each time it is queried
-   Alternatively store as blob
    -   Can't just view it
    -   But more efficient

</section>
<section markdown="1">

## 069: select field from JSON

{% include without.md file="json_field.sql" %}

-   Single arrow `->` returns JSON representation result
-   Double arrow `->>` returns SQL text, integer, real, or null
-   Left side is column
-   Right side is _path expression_
    -   Start with `$` (meaning "root")
    -   Fields separated by `.`

</section>
<section markdown="1">

## 070: JSON array access

{% include without.md file="json_array.sql" %}

-   SQLite (and other database managers) has lots of JSON manipulation functions
-   `json_array_length` gives number of elements in selected array
-   subscripts start with 0
-   Characters outside 7-bit ASCII represented as Unicode escapes

</section>
<section markdown="1">

## 071: unpack JSON array

{% include without.md file="json_unpack.sql" %}

-   `json_each` is another table-valued function
-   Use <code>json_each.<em>name</em></code> to get properties of unpacked array

</section>
<section markdown="1">

## 072: last element of array

{% include without.md file="json_array_last.sql" %}

</section>
<section markdown="1">

## 073: modify JSON

{% include without.md file="json_modify.sql" %}

-   Updates the in-memory copy of the JSON, *not* the database record
-   Please use `json_quote` rather than trying to format JSON with string operations

</section>
<section class="aside" markdown="1">

## refresh penguins

{% include without.md file="count_penguins.sql" %}

-   We will restore full database after each example

</section>
<section markdown="1">

## 074: tombstones

{% include without.md file="active_penguins.sql" %}

-   Use a _tombstone_ to mark (in)active records
-   Every query must now include it

</section>
<section markdown="1">

## 075: views

{% include without.md file="views.sql" %}

-   A _view_ is a saved query that other queries can invoke
-   View is re-run each time it's used
-   Like a CTE, but:
    -   Can be shared between queries
    -   Views came first
-   Some databases offer _materialized views_
    -   Update-on-demand temporary tables

</section>
<section class="aside" markdown="1">

## hours reminder

{% include without.md file="all_jobs.sql" %}

</section>
<section markdown="1">

## 076: add check

{% include without.md file="all_jobs_check.sql" %}

-   `check` adds constraint to table
    -   Must produce a Boolean result
    -   Run each time values added or modified
-   But changes made before the error have taken effect

</section>
<section class="aside" markdown="1">

## ACID

-   _Atomic_: change cannot be broken down into smaller ones (i.e., all or nothing)
-   _Consistent_: database goes from one consistent state to another
-   _Isolated_: looks like changes happened one after another
-   _Durable_: if change takes place, it's still there after a restart

</section>
<section markdown="1">

## 077: transactions

{% include without.md file="transaction.sql" %}

-   Statements outside transaction execute and are committed immediately
-   Statement(s) inside transaction don't take effect until:
    -   `end transaction` (success)
    -   `rollback` (undo)
-   Can have any number of statements inside a transaction
-   But *cannot* nest transactions in SQLite
    -   Other databases support this

</section>
<section markdown="1">

## 078: rollback in constraint

{% include without.md file="rollback_constraint.sql" %}

-   All of second `insert` rolled back as soon as error occurred
-   But first `insert` took effect

</section>
<section markdown="1">

## 079: rollback in statement

{% include without.md file="rollback_statement.sql" %}

-   Constraint is in table definition
-   Action is in statement

</section>
<section class="aside" markdown="1">

## normalization

-   First normal form (1NF):
    every field of every record contains one indivisible value.

-   Second normal form (2NF) and third normal form (3NF):
    every value in a record that isn't a key depends solely on the key,
    not on other values.

-   _Denormalization_: explicitly store values that could be calculated on the fly
    -   To simplify queries and/or make processing faster

</section>
<section markdown="1">

## 080: create trigger

-   A _trigger_ automatically runs before or after a specified operation
-   Can have side effects (e.g., update some other table)
-   And/or implement checks (e.g., make sure other records exist)
-   Add processing overhead…
-   …but data is either cheap or correct, never both
-   Inside trigger, refer to old and new versions of record
    as <code>old.<em>column</em></code> and <code>new.<em>column</em></code>

{% include miscfile.md file="src/trigger_setup.sql" %}
{% include without.md file="trigger_successful.sql" %}

</section>
<section markdown="1">

# 081: trigger firing

{% include without.md file="trigger_firing.sql" %}

</section>
<section class="aside" markdown="1">

## represent graphs

{% include miscfile.md file="src/lineage_setup.sql" %}
{% include without.md file="represent_graph.sql" %}

![lineage diagram](./img/lineage.svg)

</section>
<section markdown="1">

## 081: recursive query

{% include without.md file="recursive_lineage.sql" %}

-   Use a _recursive CTE_ to create a temporary table (`descendent`)
-   _Base case_ seeds this table
-   _Recursive case_ relies on value(s) already in that table and external table(s)
-   `union all` to combine rows
    -   Can use `union` but that has lower performance (must check uniqueness each time)
-   Stops when the recursive case yields an empty row set (nothing new to add)
-   Then select the desired values from the CTE

</section>
<section class="aside" markdown="1">

## contact tracing database

{% include without.md file="contact_person.sql" %}
{% include without.md file="contact_contacts.sql" %}

![contact diagram](./img/contact_tracing.svg)

</section>
<section markdown="1">

## 082: bidirectional contacts

{% include without.md file="bidirectional.sql" %}

-   Create a _temporary table_ rather than using a long chain of CTEs
    -   Only lasts as long as the session (not saved to disk)
-   Duplicate information rather than writing more complicated query

</section>
<section markdown="1">

## 083: update group identifiers

{% include without.md file="update_group_ids.sql" %}

-   `new_ident` is minimum of own identifier and identifiers one step away
-   Doesn't keep people with no contacts

</section>
<section markdown="1">

## 084: recursive labeling

{% include without.md file="recursive_labeling.sql" %}

-   Use `union` instead of `union all` to prevent _infinite recursion_

</section>
<section markdown="1">

## 085: query from Python

{% include without.md file="basic_python_query.py" %}

-   `sqlite3` is part of Python's standard library
-   Create a connection to a database file
-   Get a _cursor_ by executing a query
    -   More common to create cursor and use that to run queries
-   Fetch all rows at once as list of tuples

</section>
<section markdown="1">

## 086: incremental fetch

{% include without.md file="incremental_fetch.py" %}

-   `cursor.fetchone` returns `None` when no more data
-   There is also `fetchmany(N)` to fetch (up to) a certain number of rows

</section>
<section markdown="1">

## 087: insert, delete, and all that

{% include without.md file="insert_delete.py" %}

-   Each `execute` is its own transaction

</section>
<section markdown="1">

## 088: interpolate values

{% include without.md file="interpolate.py" %}

-   From [XKCD][xkcd-tables]

![XKCD Exploits of a Mom](./img/xkcd_327_exploits_of_a_mom.png)

</section>
<section markdown="1">

## 089: script execution

{% include without.md file="script_execution.py" %}

-   But what if something goes wrong?

</section>
<section markdown="1">

## 090: SQLite exceptions in Python

{% include without.md file="exceptions.py" %}

</section>
<section markdown="1">

## 091: Python in SQLite

{% include without.md file="embedded_python.py" %}

-   SQLite calls back into Python to execute the function
-   Other databases can run Python (and other languages) in the database server process
-   Be careful

</section>
<section markdown="1">

## 092: handle dates and times

{% include without.md file="dates_times.py" %}

-   `sqlite3.PARSE_DECLTYPES` tells `sqlite3` library to use converts based on declared column types
-   Adapt on the way in, convert on the way out

</section>
<section markdown="1">

## 093: SQL in Jupyter notebooks

{% include miscfile.md file="src/install_jupysql.sh" %}

-   And then inside the notebook:

{% include miscfile.md file="src/load_ext.txt" %}

-   Loads extension

{% include without.md file="jupyter_connect.txt" %}

-   Connects to database
    -   `sqlite://` with two slashes is the protocol
    -   `/data/penguins.db` (one leading slash) is a local path
-   Single percent sign `%sql` introduces one-line command
-   Use double percent sign `%%sql` to indicate that the rest of the cell is SQL

{% include without.md file="jupyter_select.txt" %}

<table>
  <thead>
    <tr>
      <th>species</th>
      <th>num</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Adelie</td>
      <td>152</td>
    </tr>
    <tr>
      <td>Chinstrap</td>
      <td>68</td>
    </tr>
    <tr>
      <td>Gentoo</td>
      <td>124</td>
    </tr>
  </tbody>
</table>

</section>
<section markdown="1">

## 094: Pandas and SQL

{% include miscfile.md file="src/install_pandas.sh" %}
{% include without.md file="select_pandas.py" %}

-   Be careful about datatype conversion

</section>
<section markdown="1">

## 095: Polars and SQL

{% include miscfile.md file="src/install_polars.sh" %}
{% include without.md file="select_polars.py" %}

-   The _Uniform Resource Identifier_ (URI) specifies the database
-   The query is the query
-   Use the ADBC engine instead of the default ConnectorX

</section>
<section markdown="1">

## 096: object-relational mapper

{% include without.md file="orm.py" %}

-   An _object-relational mapper_ (ORM) translates table columns to object properties and vice versa
-   SQLModel relies on Python type hints

</section>
<section markdown="1">

## 097: relations with ORM

{% include without.md file="orm_relation.py" %}

-   Make foreign keys explicit in class definitions
-   SQLModel automatically does the join
    -   The two staff with no department aren't included in the result

</section>
<section class="appendix" markdown="1">

## Appendices

### Terms

{% include glossary.html %}

### Acknowledgments

This tutorial would not have been possible without:

-   [Andi Albrecht][albrecht-andi]'s [`sqlparse`][sqlparse] module
-   [Dimitri Fontaine][fontaine-dimitri]'s [*The Art of PostgreSQL*][art-postgresql]
-   David Rozenshtein's *The Essence of SQL* (now sadly out of print)

I would also like to thank the following for spotting issues, making suggestions, or submitting changes:

{% include thanks.html %}

</section>

[albrecht-andi]: http://andialbrecht.de/
[art-postgresql]: https://theartofpostgresql.com/
[fontaine-dimitri]: https://tapoueh.org/
[fossil]: https://fossil-scm.org/
[release]: https://github.com/{{site.repository}}/blob/main/sql-tutorial.zip
[sqlparse]: https://pypi.org/project/sqlparse/
[xkcd-tables]: https://xkcd.com/327/
